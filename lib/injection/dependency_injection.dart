import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doce_blocks/data/framework/datasources.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:doce_blocks/data/repositories/repositories.dart';

enum Flavor { DEVEL }

class Injector {
  static final Injector _singleton = new Injector._internal();

  static BuildContext _context;
  static Flavor _flavor;

  static void configure(BuildContext context, Flavor flavor) {
    _context = context;
    _flavor = flavor;
  }

  static Flavor getFlavor() {
    return _flavor;
  }

  static BuildContext getContext() {
    return _context;
  }

  factory Injector() {
    return _singleton;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          FRAMEWORK
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static FirebaseAuth provideFirebaseAuth() {
    return FirebaseAuth.instance;
  }

  static Firestore provideFirestore() {
    return Firestore.instance;
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          DATASOURCE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static FirebaseDataSource provideFirebaseDataSource() {
    var firebaseAuth = Injector.provideFirebaseAuth();
    var firestore = Injector.provideFirestore();
    return FirebaseDataSourceImpl(auth: firebaseAuth, db: firestore);
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          REPOSITORY
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  static UserRepository provideUserRepository() {
    var firebaseDatasource = Injector.provideFirebaseDataSource();
    return UserRepositoryImpl(firebaseDataSource: firebaseDatasource);
  }

  Injector._internal();
}
