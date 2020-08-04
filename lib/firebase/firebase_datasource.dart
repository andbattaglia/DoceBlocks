import 'dart:async';
import 'dart:developer';

import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';


class FirebaseDataSource{

  //TODO: move into dependecies injection file
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> authenticate({
    @required String email,
    @required String password,
  }) async {
      return _auth.signInWithEmailAndPassword(email: email, password: password).then((authResult) => authResult.user.uid);
  }

}