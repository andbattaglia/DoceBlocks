import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/framework/docebo/docebo_datasource.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlockRepository {
  void addCardBlock(CardBlock block);
  void addBlocks(List<Block> blocks);
  void getBlocks(String sectionId);
  void deleteBlock(String sectionId, String blockId);
  void selectCardSize(CardSize cardSize);
  void syncDoceboCatalog(String sectionId);

  ValueStream<List<Block>> observeCachedBlocks();
  ValueStream<CardSize> observeSelectedCardSize();
}

class BlockRepositoryImpl implements BlockRepository {
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SINGLETON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final BlockRepositoryImpl _singleton = BlockRepositoryImpl._internal();

  FirebaseDataSource _firebaseDataSource;
  DoceboDataSource _doceboDataSource;

  factory BlockRepositoryImpl({
    FirebaseDataSource firebaseDataSource,
    DoceboDataSource doceboDataSource,
  }) {
    _singleton._firebaseDataSource = firebaseDataSource;
    _singleton._doceboDataSource = doceboDataSource;

    return _singleton;
  }

  BlockRepositoryImpl._internal();

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          IMPLEMENTATION
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final BehaviorSubject<CardSize> _subjectSelectedCardSize = new BehaviorSubject<CardSize>.seeded(CardSize.BIG);
  final BehaviorSubject<List<Block>> _subjectCachedBlock = new BehaviorSubject<List<Block>>.seeded(new List());

  @override
  void addBlocks(List<Block> blocks) {
    _firebaseDataSource.addBlocks(blocks.map(Block.toDocument).toList()).then((value) {
      final cachedBlock = _subjectCachedBlock.value;
      cachedBlock.addAll(blocks);
      _subjectCachedBlock.add(cachedBlock);
    });
  }

  @override
  void addCardBlock(CardBlock block) {
    block.size = _subjectSelectedCardSize.value;
    _firebaseDataSource.addBlock(Block.toDocument(block)).then((value) {
      final cachedBlock = _subjectCachedBlock.value;
      cachedBlock.add(block);
      _subjectCachedBlock.add(cachedBlock);
    });
  }

  @override
  void getBlocks(String sectionId) {
    _firebaseDataSource.getBlocks(sectionId).then((remoteValue) {
      _subjectCachedBlock.add(remoteValue);
    });
  }

  @override
  void deleteBlock(String sectionId, String blockId) {
    _firebaseDataSource.deleteBlock(sectionId).then((value) => _firebaseDataSource.getBlocks(sectionId)).then((value) => _subjectCachedBlock.add(value));
  }

  @override
  ValueStream<List<Block>> observeCachedBlocks() {
    return _subjectCachedBlock;
  }

  @override
  void selectCardSize(CardSize cardSize) {
    _subjectSelectedCardSize.add(cardSize);
  }

  @override
  ValueStream<CardSize> observeSelectedCardSize() {
    return _subjectSelectedCardSize;
  }

  @override
  void syncDoceboCatalog(String sectionId) {
    _doceboDataSource.getCatalog().then((blocks) {
      final newBlocks = blocks.map((block) {
        block.sections.add(sectionId);
        return block;
      }).toList();

      addBlocks(newBlocks);
    });
  }
}
