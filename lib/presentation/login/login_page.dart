import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doce_blocks/presentation/login/bloc/login_bloc.dart';
import 'package:doce_blocks/presentation/login/login_form.dart';

class LoginPage extends StatelessWidget {

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