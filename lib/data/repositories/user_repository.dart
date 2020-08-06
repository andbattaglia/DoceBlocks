import 'dart:async';
import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:doce_blocks/data/models/models.dart';
import 'package:meta/meta.dart';

abstract class UserRepository {
  Future<bool> authenticate({@required String email, @required String password,});
  Future<bool> isSignedIn();
  Future<void> signOut();

  Future<User> getUser();
}

class UserRepositoryImpl implements UserRepository {

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SINGLETON
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static final UserRepositoryImpl _singleton = UserRepositoryImpl._internal();

  FirebaseDataSource _firebaseDataSource;
  User _currentUser;

  factory UserRepositoryImpl({FirebaseDataSource firebaseDataSource}) {
    _singleton._firebaseDataSource = firebaseDataSource;
    return _singleton;
  }

  UserRepositoryImpl._internal();

  @override
  Future<bool> authenticate({String email, String password}) async {
    _currentUser = await _firebaseDataSource.authenticate(email: email, password: password);
    return _currentUser != null;
  }

  @override
  Future<bool> isSignedIn() async {
    _currentUser = await _firebaseDataSource.isSignedIn();
    return _currentUser != null;
  }

  @override
  Future<void> signOut() async {
    await _firebaseDataSource.signOut();
    _currentUser = null;
  }

  @override
  Future<User> getUser() async {
    return Future<User>.value(_currentUser);
  }
}