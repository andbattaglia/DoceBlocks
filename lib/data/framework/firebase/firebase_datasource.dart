import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

abstract class FirebaseDataSource {
  Future<User> authenticate({@required String email, @required String password,});
  Future<User> isSignedIn();
  Future<void> signOut();
}

class FirebaseDataSourceImpl extends FirebaseDataSource{

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
    if(currentUser != null){
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
    var snapshot = await _db.collection("users").document(uid).get();
    return User.fromMap(snapshot.documentID, snapshot.data);
  }

}