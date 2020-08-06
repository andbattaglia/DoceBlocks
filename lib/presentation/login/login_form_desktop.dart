import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginFormDesk extends StatefulWidget {
  @override
  State<LoginFormDesk> createState() => _LoginFormDeskState();
}

class _LoginFormDeskState extends State<LoginFormDesk> {
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
          Scaffold.of(context).showSnackBar(
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
          return  Center(
            child: SizedBox(
              width: 400,
              child: Card(
                elevation: 8.0,
                  child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [

                    if(state is LoginProgress) LinearProgressIndicator()
                    else LinearProgressIndicator(value: 0.0),

                    Padding(
                      padding: EdgeInsets.only(top: 32.0, left: 16.0, right: 16.0),
                      child: Text('DoceBlocks', style: Theme
                          .of(context)
                          .textTheme
                          .headline4),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 32.0, bottom: 8.0, left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 32.0, left: 16.0, right: 16.0),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 16.0, left: 16.0, right: 16.0),
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: FloatingActionButton.extended(
                            onPressed: _onLoginButtonPressed,
                            label: Text('Login'),
                            icon: Icon(Icons.send),
                            backgroundColor: Colors.blue,
                          )
                      )
                    ),

                  ],
                )
              ),
            ),
          );
        },
      ),
    );
  }
}