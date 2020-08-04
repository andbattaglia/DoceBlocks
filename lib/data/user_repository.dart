import 'dart:async';
import 'package:doce_blocks/firebase/firebase_datasource.dart';
import 'package:meta/meta.dart';

abstract class UserRepository {
  Future<String> authenticate({
    @required String email,
    @required String password,
  });
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
}