import 'dart:async';
import 'dart:developer';
import 'package:doce_blocks/data/framework/firebase/firebase_datasource.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:meta/meta.dart';

abstract class UserRepository {
  Future<bool> authenticate({@required String email, @required String password,});
  Future<bool> isSignedIn();
  Future<void> signOut();

  Future<User> getUser();
}

class UserRepositoryImpl implements UserRepository {

  FirebaseDataSource firebaseDataSource;
  User _currentUser;

  UserRepositoryImpl(FirebaseDataSource firebaseDataSource) {
    this.firebaseDataSource = firebaseDataSource;
  }

  @override
  Future<bool> authenticate({String email, String password}) async {
    _currentUser = await firebaseDataSource.authenticate(email: email, password: password);
    return _currentUser != null;
  }

  @override
  Future<bool> isSignedIn() async {
    _currentUser = await firebaseDataSource.isSignedIn();
    return _currentUser != null;
  }

  @override
  Future<void> signOut() async {
    await firebaseDataSource.signOut();
    _currentUser = null;
  }

  @override
  Future<User> getUser() async {
    return Future<User>.value(_currentUser);
  }
}