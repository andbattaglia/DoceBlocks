import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormMobile extends StatefulWidget {
  @override
  State<LoginFormMobile> createState() => _LoginFormMobileState();
}

class _LoginFormMobileState extends State<LoginFormMobile> {
  var _emailController;
  var _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: 'ab@doceblocks.com');
    _passwordController = TextEditingController(text: '123456Aa');
  }

  @override
  Widget build(BuildContext context) {

    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          email: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state is LoginSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(AuthenticationLoggedIn());
        }
      },

      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return  Padding(
              padding: EdgeInsets.only(top: 8.0, bottom: 32.0, right: 16.0, left: 16.0),
              child: Column(
                  children:[
                    Expanded(
                        flex: 1,
                        child: Container(
                            alignment: Alignment.center,
                            child: Text('DoceBlocks', style: Theme
                                .of(context)
                                .textTheme
                                .headline4)
                        )
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: TextFormField(
                              enabled: state is! LoginProgress,
                              controller: _emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: TextFormField(
                              enabled: state is! LoginProgress,
                              controller: _passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Password',
                              ),
                            ),
                          ),
                          if(state is LoginProgress) LinearProgressIndicator(),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: FloatingActionButton.extended(
                        onPressed: state is! LoginProgress ? _onLoginButtonPressed : null,
                        label: Text('Login'),
                        icon: Icon(Icons.send),
                        backgroundColor: state is! LoginProgress ? Colors.blue : Colors.grey,

                      )
                    )
                  ]
              )
          );
        },
      ),
    );
  }
}