import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/presentation/login/login_form.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      color: Theme.of(context).backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/login.png', height: 170, width: 328),
          ),

          SizedBox(
            height: DBDimens.Padding50,
          ),

          Container(
            alignment: Alignment.center,
            child: LoginForm(),
          )
        ],
      ),
    );
  }

  Widget _buildLargeLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            color: Theme.of(context).primaryColor,
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