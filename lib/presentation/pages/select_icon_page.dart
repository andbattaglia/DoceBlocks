import 'dart:developer';

import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/pages/pages_bloc.dart';
import 'package:doce_blocks/presentation/profile/profile_page.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SelectIconPage extends StatefulWidget {
  @override
  _SelectIconPageState createState() => _SelectIconPageState();
}

class _SelectIconPageState extends State<SelectIconPage> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PagesBloc>(
      create: (_) => PagesBloc()..add(GetPagesEvent()),
      child: ScreenTypeLayout(
          mobile: _buildSmallPage(context),
          tablet: OrientationLayoutBuilder(
            portrait: (context) => _buildSmallPage(context),
            landscape: (context) => _buildLargePage(context),
          ),
        desktop: _buildLargePage(context),
      )
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: Theme.of(context).accentIconTheme,
        title: Text(DBString.add_section_choose_icon_title, style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
      ),
      body: _buildContent(context)
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context){
    return Container();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CONTENT
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context){

    return Column(
      children: [
        Divider(color: Colors.grey, height: 1),
        Container(),
      ],
    );
  }
}
