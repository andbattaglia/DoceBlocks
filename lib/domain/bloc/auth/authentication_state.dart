part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final User user;

  const AuthenticationSuccess({@required this.user});

  @override
  List<Object> get props => [user.email, user.name, user.lastName];

  @override
  String toString() {
    if(user != null){
      return 'AuthenticationSuccess { ${user.uid} ${user.email} ${user.name} ${user.lastName}';
    }
    return 'AuthenticationSuccess {}';
  }
}



class AuthenticationFailure extends AuthenticationState {}