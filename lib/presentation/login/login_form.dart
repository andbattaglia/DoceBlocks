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
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(right: DBDimens.PaddingDefault, left: DBDimens.PaddingDefault),
                alignment: Alignment.centerLeft,
                child: Text(DBString.login_title, style: Theme.of(context).textTheme.headline5)
              ),

              SizedBox(
                height: DBDimens.PaddingHalf,
              ),

              Container(
                  padding: EdgeInsets.only(right: DBDimens.PaddingDefault, left: DBDimens.PaddingDefault),
                  alignment: Alignment.centerLeft,
                  child: Text(DBString.login_description, style: Theme.of(context).textTheme.subtitle2)
              ),

              SizedBox(
                height: DBDimens.Padding50,
              ),

              Container(
                padding: EdgeInsets.only(right: DBDimens.PaddingDefault, left: DBDimens.PaddingDefault),
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelStyle: new TextStyle(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).disabledColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    labelText: DBString.standard_email,
                  ),
                ),
              ),

              SizedBox(
                height: DBDimens.PaddingDefault,
              ),

              Container(
                padding: EdgeInsets.only(right: DBDimens.PaddingDefault, left: DBDimens.PaddingDefault),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelStyle: new TextStyle(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).disabledColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    labelText: DBString.standard_password,
                  ),
                ),
              ),

              SizedBox(
                height: DBDimens.PaddingDouble,
              ),

              Container(
                padding: EdgeInsets.only(left:  DBDimens.PaddingDefault, right:  DBDimens.PaddingDefault),
                alignment: Alignment.centerRight,
                child:  RaisedButton(
                  onPressed: _onLoginButtonPressed,
                  padding: EdgeInsets.only(left:  DBDimens.PaddingDouble, right:  DBDimens.PaddingDouble),
                  child: Text(DBString.standard_login.toUpperCase(), style: Theme.of(context).accentTextTheme.button),
                  color: Theme.of(context).buttonColor,
                ),
              )

            ],
          );
        },
      ),
    );
  }
}