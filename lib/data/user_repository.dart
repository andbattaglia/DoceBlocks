import 'dart:async';

import 'package:meta/meta.dart';

abstract class UserRepository {
  Future<String> authenticate();
  Future<void> deleteToken();
  Future<void> persistToken(String token);
  Future<bool> hasToken();
}

class UserRepositoryImpl implements UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return 'token';
  }

  @override
  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  @override
  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  @override
  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}