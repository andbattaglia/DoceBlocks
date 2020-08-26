import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/presentation/pages/pages_list_page.dart';
import 'package:doce_blocks/presentation/profile/profile_page.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:doce_blocks/presentation/widget/composer/widget_composer_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _buildSmallPage(context),
      tablet: OrientationLayoutBuilder(
        portrait: (context) => _buildSmallPage(context),
        landscape: (context) => _buildLargePage(context),
      ),
      desktop: _buildLargePage(context),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: Theme.of(context).primaryIconTheme,
        elevation: 0.0,
        title: Text(DBString.title, style: Theme.of(context).textTheme.headline6),
        actions: <Widget>[
          _buildProfileAvatar(context)
        ],
      ),
      drawer: Drawer(
          child: PagesListPage()
      ),
      body: WidgetComposerPage(),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context){
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [ Theme.of(context).primaryColor,  Theme.of(context).primaryColorLight ]
            )
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: PagesListPage(),
            ),
            Expanded(
                flex: 3,
                child: WidgetComposerPage()
            ),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          OTHERS
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildProfileAvatar(BuildContext context){
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state){
        if(state is AuthenticationSuccess){
          return Container(
            padding: EdgeInsets.only(right: DBDimens.PaddingQuarter, left: DBDimens.PaddingQuarter),
            child: GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (BuildContext context) => ProfilePage());
              },
              child:CircleAvatar(
                backgroundColor: Theme.of(context).primaryColorDark,
                child: Text('${state.user.name[0]}${state.user.lastName[0]}', style: Theme.of(context).accentTextTheme.headline6),
              ),
            ),
          );
        }
        return null;
      },
    );

  }
}