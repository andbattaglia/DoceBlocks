import 'dart:async';
import 'package:doce_blocks/data/models/models.dart';
import 'package:rxdart/rxdart.dart';

abstract class AppRepository {
  Future<List<DBIcon>> getIcons();
  Future<DBIcon> getSelectedIcon();
  ValueStream<DBIcon> observeSelectedIcon();
  void selectIcon(int iconId);

  Future<List<CardSize>> getCardSizeValues();
}

class AppRepositoryImpl implements AppRepository {
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SINGLETON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final AppRepositoryImpl _singleton = AppRepositoryImpl._internal();

  factory AppRepositoryImpl() {
    return _singleton;
  }

  AppRepositoryImpl._internal();

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          ICONS
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  BehaviorSubject<DBIcon> _subjectSelectedIcon = new BehaviorSubject<DBIcon>.seeded(DBIcon.generateIcons()[0]);

  @override
  Future<List<DBIcon>> getIcons() {
    return Future<List<DBIcon>>.value(DBIcon.generateIcons());
  }

  @override
  Future<DBIcon> getSelectedIcon() {
    return Future<DBIcon>.value(_subjectSelectedIcon.value);
  }

  @override
  ValueStream<DBIcon> observeSelectedIcon() {
    return _subjectSelectedIcon.stream;
  }

  @override
  void selectIcon(int iconId) {
    var icons = DBIcon.generateIcons();
    var icon = icons.firstWhere((element) => element.id == iconId);
    _subjectSelectedIcon.add(icon);
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CARD SIZE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<List<CardSize>> getCardSizeValues() {
    return Future<List<CardSize>>.value([CardSize.BIG, CardSize.SMALL]);
  }
}
