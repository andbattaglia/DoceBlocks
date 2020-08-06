import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/data/repositories/repositories.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {

  UserRepository _userRepository;

  AuthenticationBloc() : super(AuthenticationInitial()){
    _userRepository = Injector.provideUserRepository();
  }

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* _mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* _mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* _mapAuthenticationLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationStartedToState() async* {
    final isSignedIn = await _userRepository.isSignedIn();
    if (isSignedIn) {
      var user = await _userRepository.getUser();
      yield AuthenticationSuccess(user: user);
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedInToState() async* {
    var user = await _userRepository.getUser();
    yield AuthenticationSuccess(user: user);
  }

  Stream<AuthenticationState> _mapAuthenticationLoggedOutToState() async* {
    var userRepository = Injector.provideUserRepository();
    await userRepository.signOut();
    yield AuthenticationFailure();
  }
}