import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/presentation/login/login_form.dart';
import 'package:doce_blocks/presentation/utils/colors.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
          create: (context) {
            return LoginBloc();
          },
          child: LayoutBuilder(builder: (builder, constraints) {
            var size = DBDimens.getScreenSize(constraints.maxWidth);
            switch(size){
              case ScreenSize.LARGE:
                return _buildLargeLayout();
              case ScreenSize.MEDIUM:
                return _buildSmallLayout(maxWidth: 400);
              case ScreenSize.SMALL:
                return _buildSmallLayout();
            }
            return Container();
          }),
        )
    );
  }

  Widget _buildSmallLayout({double maxWidth}) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ DBColors.GradientColorOne, DBColors.GradientColorTwo]
            )
        ),
        child:  Container(
          margin: EdgeInsets.only(left: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault),
          alignment: Alignment.center,
          child: SizedBox(
            width: maxWidth,
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

  Widget _buildLargeLayout() {
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
                    colors: [ DBColors.GradientColorOne, DBColors.GradientColorTwo]
                )
            ),
            child: Image.asset('assets/login.png'),
          ),
        ),
        Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              color: Colors.white,
              child: LoginForm(),
            )
        )
      ],
    );
  }
}