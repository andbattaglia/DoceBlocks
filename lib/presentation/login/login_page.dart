import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/presentation/login/login_form_desktop.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doce_blocks/presentation/login/login_form_mobile.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kIsWeb ?  Colors.grey[200] : Colors.white,
      body: SafeArea(
        child: BlocProvider(
          create: (context) {
            return LoginBloc();
          },
          child: kIsWeb ?  LoginFormDesk() : LoginFormMobile(),
        ),
      )
    );
  }
}