import 'dart:developer';

import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/pages/pages_bloc.dart';
import 'package:doce_blocks/presentation/pages/select_icon_page.dart';
import 'package:doce_blocks/presentation/profile/profile_page.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddPagePage extends StatefulWidget {
  @override
  _AddPagePageState createState() => _AddPagePageState();
}

class _AddPagePageState extends State<AddPagePage> {

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
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        iconTheme: Theme.of(context).accentIconTheme,
        title: Text(DBString.add_section_title, style: Theme.of(context).textTheme.headline6),
        elevation: 0.0,
        actions: [
          FlatButton(
            onPressed: () {
              // Respond to button press
            },
            child: Text(DBString.standard_done, style: Theme.of(context).primaryTextTheme.button),
          )
        ],
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

    var _inputController = TextEditingController();

    return Column(
      children: [

        Divider(color: Colors.grey, height: 1),
        Container(
          padding: EdgeInsets.all(DBDimens.PaddingDefault),
          child: TextFormField(
            controller: _inputController,
            decoration: new InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: DBString.add_section_hint,
            ),
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (value) {
              if(value.trim().isNotEmpty){
//              Navigator.of(context, rootNavigator: true).pop();
//              BlocProvider.of<PagesBloc>(context).add(AddPageEvent(name: value.trim()));
              }
            },
          ),
        ),
        Divider(color: Colors.grey, height: 1),
        InkWell(
          child: Container(
            padding: EdgeInsets.all(DBDimens.PaddingDefault),
            child: Row(
              children: [
                Icon(Icons.apps, color: Theme.of(context).accentIconTheme.color), //TODO: CHANGE WITH SELECTED ICON
                SizedBox(width: DBDimens.PaddingDefault),
                Expanded(child: Text("Text")),
                Icon(Icons.chevron_right, color: Theme.of(context).accentIconTheme.color),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SelectIconPage()));
          },
        ),
        Divider(color: Colors.grey, height: 1),
      ],
    );
  }
}
