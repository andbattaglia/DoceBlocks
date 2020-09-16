import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:rxdart/rxdart.dart';

abstract class SectionRepository {
  void setCurrentSection(String uid);

  void addSection(String userId, String name, String icon);
  Future<bool> getSections(String userId);
  void deleteSection(String userId, String pageId);

  ValueStream<List<Section>> observeCachedSections();
  ValueStream<Section> observeSelectedSection();
  String getSelectedSectionId();
}

class SectionRepositoryImpl implements SectionRepository {
  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SINGLETON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final SectionRepositoryImpl _singleton = SectionRepositoryImpl._internal();

  FirebaseDataSource _firebaseDataSource;

  factory SectionRepositoryImpl({FirebaseDataSource firebaseDataSource}) {
    _singleton._firebaseDataSource = firebaseDataSource;
    return _singleton;
  }

  SectionRepositoryImpl._internal();

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          IMPLEMENTATION
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  final BehaviorSubject<List<Section>> _subjectCachedSections = new BehaviorSubject<List<Section>>.seeded(new List());
  final BehaviorSubject<Section> _subjectSelectedSection = new BehaviorSubject<Section>();

  @override
  void setCurrentSection(String uid) {
    final Section page = _subjectCachedSections.value.firstWhere((element) => element.uid == uid);
    _subjectSelectedSection.add(page);

    _subjectCachedSections.add(setSelected(_subjectCachedSections.value));
  }

  @override
  void addSection(String userId, String name, String icon) {
    _firebaseDataSource.addSection(userId, name, icon).then((value) => _firebaseDataSource.getSections(userId)).then((value) {
      _subjectCachedSections.add(setSelected(value));
    });
  }

  @override
  Future<bool> getSections(String userId) async {
    await _firebaseDataSource.getSections(userId)
        .then((remoteValue) {
          _subjectCachedSections.add(setSelected(remoteValue));
          return true;
        });
  }

  @override
  void deleteSection(String userId, String pageId) async {
    await _firebaseDataSource.deleteSection(pageId)
        .then((value) => _firebaseDataSource.getSections(userId))
        .then((value) =>_subjectCachedSections.add(setSelected(value, id: pageId)));
  }

  @override
  ValueStream<List<Section>> observeCachedSections() {
    return _subjectCachedSections;
  }

  @override
  ValueStream<Section> observeSelectedSection() {
    return _subjectSelectedSection;
  }

  @override
  String getSelectedSectionId() {
    return _subjectSelectedSection.value.uid;
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          UTILS METHOD
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  List<Section> setSelected(List<Section> list, {String id}) {
    final Section currentSection = _subjectSelectedSection.value;

    if (currentSection == null || currentSection.uid == id) {
      if (list.isNotEmpty) {
        list[0].isSelected = true;
        _subjectSelectedSection.add(list[0]);
      } else {
        _subjectSelectedSection.add(null);
      }
    } else {
      list.asMap().forEach((index, value) {
        value.isSelected = value.uid == currentSection.uid;
      });
    }
    return list;
  }
}
