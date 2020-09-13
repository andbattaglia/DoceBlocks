import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/data/models/page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

abstract class FirebaseDataSource {
  Future<User> authenticate({
    @required String email,
    @required String password,
  });
  Future<User> isSignedIn();
  Future<void> signOut();

  Future<CustomPage> addPage(String userId, String name, String icon);
  Future<void> deletePage(String pageId);
  Future<List<CustomPage>> getPages(String userId);
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
  //          PAGE METHOD
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  @override
  Future<CustomPage> addPage(String userId, String name, String icon) async {

    CollectionReference dbReference = _db.collection('pages');

    var result = await dbReference.add({
      'userId': userId,
      'name': name,
      'icon': icon,
    });

    var snapshot = await dbReference.document(result.documentID).get();
    return CustomPage.fromJson(result.documentID, snapshot);
  }

  @override
  Future<List<CustomPage>> getPages(String userId) async {
    CollectionReference dbReference = _db.collection('pages');

    var snapshot = await dbReference.where('userId', isEqualTo: userId).getDocuments();

    var result = List<CustomPage>();
    snapshot.documents.forEach((item) {
      result.add(CustomPage.fromJson(item.documentID, item.data));
    });

    return result;
  }

  @override
  Future<void> deletePage(String pageId) {
    CollectionReference dbReference = _db.collection('pages');
    return dbReference.document(pageId).delete();
  }
}
