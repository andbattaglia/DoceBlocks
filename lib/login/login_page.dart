import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doce_blocks/login/bloc/login_bloc.dart';
import 'package:doce_blocks/login/login_form.dart';

class LoginPage extends StatelessWidget {
//  final UserRepository userRepository;

//  LoginPage({Key key, @required this.userRepository})
//      : assert(userRepository != null),
//        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc();
        },
        child: LoginForm(),
      ),
    );
  }
}