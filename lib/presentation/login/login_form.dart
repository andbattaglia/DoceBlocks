import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:doce_blocks/presentation/utils/themes.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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
          return Wrap(
            alignment: WrapAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: DBDimens.PaddingDouble, left: DBDimens.PaddingDouble, right: DBDimens.PaddingDouble),
                child: Text(DBString.login_title, style: Theme.of(context).textTheme.headline4)
              ),

              Container(
                padding: EdgeInsets.only(top: DBDimens.PaddingDouble, bottom: DBDimens.PaddingHalf, left: DBDimens.PaddingDouble, right: DBDimens.PaddingDouble),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelStyle: new TextStyle(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).primaryColor
                      ),
                    ),
                    labelText: DBString.login_email_hint,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top:  DBDimens.PaddingHalf, bottom: DBDimens.PaddingDouble, left:  DBDimens.PaddingDouble, right:  DBDimens.PaddingDouble),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: new TextStyle(),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).primaryColor
                      ),
                    ),
                    labelText: DBString.login_password_hint,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top:  DBDimens.PaddingDefault, bottom:  DBDimens.PaddingDouble, left:  DBDimens.PaddingDouble, right:  DBDimens.PaddingDouble),
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: FloatingActionButton.extended(
                        onPressed: _onLoginButtonPressed,
                        label: Text(DBString.login_button, style: Theme.of(context).accentTextTheme.button),
                        icon: Icon(Icons.send, color: Theme.of(context).iconTheme.color),
                        backgroundColor: Theme.of(context).buttonColor,
                      )
                  )
              ),

            ],
          );
        },
      ),
    );
  }
}