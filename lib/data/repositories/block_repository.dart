import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:rxdart/rxdart.dart';

abstract class BlockRepository {
  Future<List<String>> addBlocks(List<Block> blocks);
  void getBlocks(String pageId);

  ValueStream<List<Block>> observeCachedBlocks();
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
  final BehaviorSubject<List<Block>> _subjectCachedBlock = new BehaviorSubject<List<Block>>.seeded(new List());


  @override
  Future<List<String>> addBlocks(List<Block> blocks) {
    return _firebaseDataSource.addBlocks(blocks.map(Block.toDocument).toList());
  }

  @override
  void getBlocks(String pageId) {
    _firebaseDataSource.getBlocks(pageId).then((remoteValue) {
      _subjectCachedBlock.add(remoteValue);
    });
  }

  @override
  ValueStream<List<Block>> observeCachedBlocks() {
    return _subjectCachedBlock;
  }
}
