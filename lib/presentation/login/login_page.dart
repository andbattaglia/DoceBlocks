import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/injection/dependency_injection.dart';
import 'package:doce_blocks/presentation/login/login_form.dart';
import 'package:doce_blocks/presentation/utils/themes.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) {
            return LoginBloc();
          },
          child: ScreenTypeLayout(
              mobile: _buildSmallLayout(context),
              tablet: OrientationLayoutBuilder(
                portrait: (context) => _buildSmallLayout(context),
                landscape: (context) => _buildLargeLayout(context),
              ),
              desktop:_buildLargeLayout(context),
          ),
        )
    );
  }

  Widget _buildSmallLayout(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ Theme.of(context).primaryColor,  Theme.of(context).primaryColorLight ]
            )
        ),
        child:  Container(
          margin: EdgeInsets.only(left: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault),
          alignment: Alignment.center,
          child: Container(
            constraints: BoxConstraints(maxWidth: 400),
            child:Card(
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DBDimens.CornerDefault),
                ),
                child: LoginForm()
            ),
          ),)
    );
  }

  Widget _buildLargeLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(left: DBDimens.PaddingDouble, right: DBDimens.PaddingDouble),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [ Theme.of(context).primaryColor,  Theme.of(context).primaryColorLight ]
                )
            ),
            child: Image.asset('assets/login.png'),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              color: Theme.of(context).backgroundColor,
              child: LoginForm(),
            )
        )
      ],
    );
  }
}