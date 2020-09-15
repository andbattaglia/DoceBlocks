import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/models.dart';

abstract class BlockRepository {
  Future<List<String>> addBlocks(List<Block> blocks);
  Future<List<Block>> getBlocks(String pageId);
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
  @override
  Future<List<String>> addBlocks(List<Block> blocks) {
    return _firebaseDataSource.addBlocks(blocks.map(Block.toDocument).toList());
  }

  @override
  Future<List<Block>> getBlocks(String pageId) {
    return _firebaseDataSource.getBlocks(pageId);
  }
}
