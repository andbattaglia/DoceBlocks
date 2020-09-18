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
                backgroundColor: Theme.of(context).backgroundColor,
                iconTheme: Theme.of(context).accentIconTheme,
                elevation: 0.0,
                title:
                    Text(title, style: Theme.of(context).textTheme.headline6),
              ),
              drawer: Drawer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          top: DBDimens.Padding100,
                          left: DBDimens.PaddingDefault,
                          right: DBDimens.PaddingDefault,
                          bottom: DBDimens.PaddingDefault),
                      child: CrossPlatformSvg.asset('assets/logo.svg'),
                    ),
                    Divider(color: Colors.grey, height: 1),
                    _buildHeader(context),
                    Divider(color: Colors.grey, height: 1),
                    Expanded(
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: DBDimens.ToolbarHeigth,
              padding: EdgeInsets.all(DBDimens.PaddingDefault),
              child: CrossPlatformSvg.asset('assets/logo.svg', height: 30),
            ),
            Divider(color: Colors.grey, height: 1),
            Expanded(
                child: Container(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildHeader(context),
                        Divider(color: Colors.grey, height: 1),
                        Expanded(
                          child: SectionsListPage(),
                        ),
                      ],
                    ),
                  ),

                  Expanded(flex: 3, child: BlockComposerPage()),
                ],
              ),
            )),
          ],
        )));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: DBDimens.PaddingHalf,
          right: DBDimens.PaddingHalf,
          bottom: DBDimens.PaddingHalf),
      child: new InkWell(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(DBDimens.CornerDefault),
              bottomRight: Radius.circular(DBDimens.CornerDefault)),
          onTap: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePage())),
          child: Container(
            padding: EdgeInsets.all(DBDimens.PaddingDefault),
            child: Row(
              children: [
                Icon(Icons.account_circle,
                    color: Theme.of(context).primaryIconTheme.color),
                SizedBox(width: DBDimens.PaddingHalf),
                Expanded(
                    child: Text(DBString.profile_title,
                        style: Theme.of(context).textTheme.bodyText1)),
              ],
            ),
          )),
    );
  }
}
