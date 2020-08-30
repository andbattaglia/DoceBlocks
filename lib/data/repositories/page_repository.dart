import 'dart:async';
import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/models.dart';

abstract class PageRepository {
  Future<Page> getPage(final String uid);
  Future<List<Page>> getPages();
}

class PageRepositoryImpl implements PageRepository {
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SINGLETON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final PageRepositoryImpl _singleton = PageRepositoryImpl._internal();

  FirebaseDataSource _firebaseDataSource;

  factory PageRepositoryImpl({FirebaseDataSource firebaseDataSource}) {
    _singleton._firebaseDataSource = firebaseDataSource;
    return _singleton;
  }

  PageRepositoryImpl._internal();

  @override
  Future<Page> getPage(String uid) {
    return _firebaseDataSource.getPage(uid);
  }

  @override
  Future<List<Page>> getPages() {
    return _firebaseDataSource.getPages();
  }
}
