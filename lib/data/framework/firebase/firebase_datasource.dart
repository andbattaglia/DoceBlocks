import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:meta/meta.dart';


class FirebaseDataSource{

  FirebaseAuth _auth;
  Firestore _db;

  FirebaseDataSource(FirebaseAuth auth, Firestore db) {
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
    var snapshot = await _db.collection("users").document(uid).get();
    return User.fromMap(snapshot.data);
  }

}