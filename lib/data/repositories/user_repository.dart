import 'dart:async';
import 'package:doce_blocks/data/framework/firebase/firebase_datasource.dart';
import 'package:meta/meta.dart';

abstract class UserRepository {
  Future<String> authenticate({@required String email, @required String password,});
  Future<bool> isSignedIn();
  Future<void> signOut();
}

class UserRepositoryImpl implements UserRepository {

  FirebaseDataSource firebaseDataSource;

  UserRepositoryImpl(FirebaseDataSource firebaseDataSource) {
    this.firebaseDataSource = firebaseDataSource;
  }

  @override
  Future<String> authenticate({String email, String password}) async {
    return await firebaseDataSource.authenticate(email: email, password: password);
  }

  @override
  Future<bool> isSignedIn() async {
    return await firebaseDataSource.isSignedIn();
  }

  @override
  Future<void> signOut() async {
    return await firebaseDataSource.signOut();
  }
}