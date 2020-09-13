import 'dart:async';
import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/icon.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

abstract class PageRepository {

  List<CustomPage> setCurrentPage(String uid);

  void addPage(String userId, String name, String icon);
  void getPages(String userId);
  void deletePages(String userId, String pageId);

  ValueStream<List<CustomPage>> observeCachedPages();
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

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          IMPLEMENTATION
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  BehaviorSubject<List<CustomPage>> _subjectCachedPages = new BehaviorSubject<List<CustomPage>>.seeded(new List());

  String _currentPageId;

  @override
  List<CustomPage> setCurrentPage(String uid) {
//    if(_cachedPages.isNotEmpty){
//      _currentPageId = uid;
//      _cachedPages.asMap().forEach((index, value) {
//        value.isSelected = value.uid == uid;
//      });
//    }
//
//    return _cachedPages;
  }

  @override
  void addPage(String userId, String name, String icon) {
    _firebaseDataSource.addPage(userId, name, icon)
        .then((value) => _firebaseDataSource.getPages(userId))
        .then((value) => _subjectCachedPages.add(value));
  }

  @override
  void getPages(String userId) {
    _firebaseDataSource.getPages(userId)
        .then((remoteValue) => _subjectCachedPages.add(remoteValue));
  }

  @override
  void deletePages(String userId, String pageId) async {
    await _firebaseDataSource.deletePage(pageId)
        .then((value) => _firebaseDataSource.getPages(userId))
        .then((value) => _subjectCachedPages.add(value));
  }

  @override
  ValueStream<List<CustomPage>> observeCachedPages() {
    return _subjectCachedPages;
  }
}
