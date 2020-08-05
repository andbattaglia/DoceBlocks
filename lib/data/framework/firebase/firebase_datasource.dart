import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:doce_blocks/data/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';


class FirebaseDataSource{

  FirebaseAuth _auth;
  FirebaseDatabase _db;

  FirebaseDataSource(FirebaseAuth auth, FirebaseDatabase db) {
    this._auth = auth;
    this._db = db;
  }

  Future<User> authenticate({
    @required String email,
    @required String password,
  }) async {
      var uid = await _auth.signInWithEmailAndPassword(email: email, password: password).then((authResult) => authResult.user.uid);
      return await _getUser(uid);
  }

  Future<User> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    if(currentUser != null){
      return _getUser(currentUser.uid);
    }
    return null;
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }

  Future<User> _getUser(String uid) async {
    var snapshot = await _db.reference().child('users').orderByChild("uid").equalTo(uid).limitToFirst(1).once();
    return User.fromMap(snapshot.value[0]);
  }

}