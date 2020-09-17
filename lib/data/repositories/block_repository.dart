import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlockRepository {
  void addCardBlock(CardBlock block);

  void addBlocks(List<Block> blocks);
  void getBlocks(String pageId);

  ValueStream<List<Block>> observeCachedBlocks();

  void selectCardSize(CardSize cardSize);
  ValueStream<CardSize> observeSelectedCardSize();
}

class BlockRepositoryImpl implements BlockRepository {
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SINGLETON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final BlockRepositoryImpl _singleton = BlockRepositoryImpl._internal();

  FirebaseDataSource _firebaseDataSource;

  factory BlockRepositoryImpl({FirebaseDataSource firebaseDataSource}) {
    _singleton._firebaseDataSource = firebaseDataSource;
    return _singleton;
  }

  BlockRepositoryImpl._internal();

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          IMPLEMENTATION
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  final BehaviorSubject<CardSize> _subjectSelectedCardSize =
      new BehaviorSubject<CardSize>.seeded(CardSize.BIG);

  final BehaviorSubject<List<Block>> _subjectCachedBlock =
      new BehaviorSubject<List<Block>>.seeded(new List());

  @override
  void addBlocks(List<Block> blocks) {
    _firebaseDataSource
        .addBlocks(blocks.map(Block.toDocument).toList())
        .then((value) {
      var cachedBlock = _subjectCachedBlock.value;
      cachedBlock.addAll(blocks);
      _subjectCachedBlock.add(cachedBlock);
    });
  }

  @override
  void addCardBlock(CardBlock block) {
    block.size = _subjectSelectedCardSize.value;
    _firebaseDataSource.addBlock(Block.toDocument(block)).then((value) {
      var cachedBlock = _subjectCachedBlock.value;
      cachedBlock.add(block);
      _subjectCachedBlock.add(cachedBlock);
    });
  }

  @override
  void getBlocks(String pageId) {
    _firebaseDataSource.getBlocks(pageId).then((remoteValue) {
      _subjectCachedBlock.add(remoteValue);
    });
  }

  @override
  void deleteBlock(String userId, String blockId) async {
    await _firebaseDataSource
        .deleteSection(pageId)
        .then((value) => _firebaseDataSource.getSections(userId))
        .then((value) =>
            _subjectCachedSections.add(setSelected(value, id: pageId)));
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
}
