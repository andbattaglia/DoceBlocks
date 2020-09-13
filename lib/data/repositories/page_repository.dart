import 'dart:async';
import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/icon.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

abstract class PageRepository {

  void setCurrentPage(String uid);

  void addPage(String userId, String name, String icon);
  void getPages(String userId);
  void deletePages(String userId, String pageId);

  ValueStream<List<CustomPage>> observeCachedPages();
  ValueStream<CustomPage> observeSelectedPages();
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
  BehaviorSubject<CustomPage> _subjectSelectedPage = new BehaviorSubject<CustomPage>();

  @override
  void setCurrentPage(String uid) {
      CustomPage page = _subjectCachedPages.value.firstWhere((element) => element.uid == uid);
      _subjectSelectedPage.add(page);

      _subjectCachedPages.add(setSelected(_subjectCachedPages.value));
  }

  @override
  void addPage(String userId, String name, String icon) {
    _firebaseDataSource.addPage(userId, name, icon)
        .then((value) => _firebaseDataSource.getPages(userId))
        .then((value) {
          _subjectCachedPages.add(setSelected(value));
        });
  }

  @override
  void getPages(String userId) {
    _firebaseDataSource.getPages(userId)
        .then((remoteValue) {
          _subjectCachedPages.add(setSelected(remoteValue));
        });
  }

  @override
  void deletePages(String userId, String pageId) async {
    await _firebaseDataSource.deletePage(pageId)
        .then((value) => _firebaseDataSource.getPages(userId))
        .then((value) {
          _subjectCachedPages.add(setSelected(value, id: pageId));
        });
  }

  @override
  ValueStream<List<CustomPage>> observeCachedPages() {
    return _subjectCachedPages;
  }

  @override
  ValueStream<CustomPage> observeSelectedPages() {
    return _subjectSelectedPage;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          UTILS METHOD
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  List<CustomPage> setSelected(List<CustomPage> list, {String id})  {
    CustomPage currentPage = _subjectSelectedPage.value;

    if(currentPage == null || currentPage.uid == id){
      if(list.isNotEmpty){
        list[0].isSelected = true;
        _subjectSelectedPage.add(list[0]);
      } else {
        _subjectSelectedPage.add(null);
      }
    } else {
      list.asMap().forEach((index, value) {
        value.isSelected = value.uid == currentPage.uid;
      });
    }
    return list;
  }
}
