import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/domain/bloc/sections/sections_bloc.dart';
import 'package:doce_blocks/presentation/block/composer/block_composer_page.dart';
import 'package:doce_blocks/presentation/pages/sections_list_page.dart';
import 'package:doce_blocks/presentation/profile/profile_page.dart';
import 'package:doce_blocks/presentation/utils/cross_platform_svg.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SectionsBloc _sectionsBloc;

  @override
  void initState() {
    _sectionsBloc = SectionsBloc()..add(GetSectionsEvent());
  }

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
  Widget _buildSmallPage(BuildContext context) {
    return StreamBuilder(
        stream: _sectionsBloc.getSelectedSectionStream(),
        builder: (context, AsyncSnapshot<Section> snapshot) {
          String title = DBString.title;
          if (snapshot.hasData) {
            title = snapshot.data.name;
          }

          return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                iconTheme: Theme.of(context).accentIconTheme,
                elevation: 0.0,
                title: Text(title, style: Theme.of(context).textTheme.headline6),
                actions: <Widget>[_buildProfileAvatar(context)],
              ),
              drawer: Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: DrawerHeader(
                        child: CrossPlatformSvg.asset('assets/logo.svg'),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: SectionsListPage(),
                    ),
                  ],
                ),
              ),
              body: BlockComposerPage());
        });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SectionsListPage(),
            ),
            Expanded(flex: 3, child: BlockComposerPage()),
          ],
        ),
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          OTHERS
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildProfileAvatar(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthenticationSuccess) {
          return Container(
            padding: EdgeInsets.only(right: DBDimens.PaddingQuarter, left: DBDimens.PaddingQuarter),
            child: GestureDetector(
              onTap: () {
                showDialog(context: context, builder: (BuildContext context) => ProfilePage());
              },
              child: CircleAvatar(
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
