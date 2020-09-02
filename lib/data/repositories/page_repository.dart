import 'dart:async';
import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:flutter/cupertino.dart';

abstract class PageRepository {

  List<CustomPage> setCurrentPage(String uid);

  Future<bool> setPage(String userId, String name);
  Future<bool> deletePages(String pageId);

  Future<List<CustomPage>> getPages(String userId, bool fromCache);
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

  List<CustomPage> _cachedPages = List<CustomPage>();
  String _currentPageId;

  @override
  List<CustomPage> setCurrentPage(String uid) {
    if(_cachedPages.isNotEmpty){
      _currentPageId = uid;
      _cachedPages.asMap().forEach((index, value) {
        value.isSelected = value.uid == uid;
      });
    }

    return _cachedPages;
  }

  @override
  Future<bool> setPage(String userId, String name) {
    return _firebaseDataSource.setPage(userId, name);
  }

  @override
  Future<bool> deletePages(String pageId) {
    if(pageId == _currentPageId && _cachedPages.isNotEmpty){
      _currentPageId = _cachedPages[0].uid;
    } else {
      _currentPageId = null;
    }

    if(_cachedPages.length > 1){
      return _firebaseDataSource.deletePage(pageId);
    }
     return Future<bool>.value(false);
  }

  @override
  Future<List<CustomPage>> getPages(String userId, bool fromCache) {
    if(fromCache){
      return Future<List<CustomPage>>.value(_cachedPages);
    }

    return _firebaseDataSource.getPages(userId)
        .then((remoteValue) {
          _cachedPages = remoteValue;
          if(_currentPageId != null){
            _cachedPages.asMap().forEach((index, value) {
              value.isSelected = value.uid == _currentPageId;
            });
          }
          return _cachedPages;
    });
  }
}
