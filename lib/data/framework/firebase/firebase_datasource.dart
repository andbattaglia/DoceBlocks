import 'dart:async';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class FirebaseDataSource {
  Future<User> authenticate({
    @required String email,
    @required String password,
  });
  Future<User> isSignedIn();
  Future<void> signOut();

  Future<Section> addSection(String userId, String name, String icon);
  Future<void> deleteSection(String sectionId);
  Future<List<Section>> getSections(String userId);

  Future<List<Block>> getBlocks(String pageId);
}

class FirebaseDataSourceImpl extends FirebaseDataSource {
  FirebaseAuth _auth;
  Firestore _db;

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SINGLETON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final FirebaseDataSourceImpl _singleton = FirebaseDataSourceImpl._internal();

  factory FirebaseDataSourceImpl({FirebaseAuth auth, Firestore db}) {
    _singleton._auth = auth;
    _singleton._db = db;
    return _singleton;
  }

  FirebaseDataSourceImpl._internal();

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          AUTH METHOD
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<User> authenticate({
    @required String email,
    @required String password,
  }) async {
    var authResp = await _auth.signInWithEmailAndPassword(email: email, password: password);
    var user = await _getUser(authResp.user.uid);
    return user;
  }

  @override
  Future<User> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    if (currentUser != null) {
      var user = await _getUser(currentUser.uid);
      return user;
    }
    return null;
  }

  @override
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<User> _getUser(String uid) async {
    CollectionReference dbReference = _db.collection('users');
    var snapshot = await dbReference.document(uid).get();
    return User.fromMap(snapshot.documentID, snapshot.data);
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SECTION METHOD
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<Section> addSection(String userId, String name, String icon) async {
    final CollectionReference dbReference = _db.collection('sections');

    final result = await dbReference.add({
      'userId': userId,
      'name': name,
      'icon': icon,
    });

    final snapshot = await dbReference.document(result.documentID).get();

    return Section.fromJson(result.documentID, snapshot);
  }

  @override
  Future<List<Section>> getSections(String userId) async {
    final CollectionReference dbReference = _db.collection('sections');

    final snapshot = await dbReference.where('userId', isEqualTo: userId).getDocuments();

    var result = List<Section>();

    snapshot.documents.forEach((item) {
      result.add(Section.fromJson(item.documentID, item.data));
    });

    return result;
  }

  @override
  Future<void> deleteSection(String sectionId) {
    final CollectionReference dbReference = _db.collection('sections');
    return dbReference.document(sectionId).delete();
  }

  @override
  Future<List<Block>> getBlocks(String pageId) async {
    final CollectionReference dbReference = _db.collection('blocks');
    final snapshot = await dbReference.where('pages', arrayContains: pageId).getDocuments();

    return snapshot.documents.map((document) => Block.fromJson(document.data));
  }
}
