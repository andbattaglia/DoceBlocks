import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';


class FirebaseDataSource{

  FirebaseAuth _auth;

  FirebaseDataSource(FirebaseAuth auth) {
    this._auth = auth;
  }

  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async {
      return _auth.signInWithEmailAndPassword(email: email, password: password).then((authResult) => authResult.user.uid);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }


}