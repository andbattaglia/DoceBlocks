import 'dart:developer';

import 'package:doce_blocks/data/models/icon.dart';
import 'package:doce_blocks/domain/bloc/dbicon/db_icon_bloc.dart';
import 'package:doce_blocks/domain/bloc/pages/pages_bloc.dart';
import 'package:doce_blocks/presentation/dbicon/select_icon_page.dart';
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

  IconBloc _iconBloc;

  var _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
     _iconBloc = new IconBloc()..add(SelectIconEvent(iconId: 0));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PagesBloc>(
      create: (_) => PagesBloc(),
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
    return BlocBuilder<PagesBloc, PagesState>(
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).backgroundColor,
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
                      var value = _inputController.text.trim();
                      if(value.trim().isNotEmpty){
                        BlocProvider.of<PagesBloc>(context).add(AddPageEvent(name: value));
                        Navigator.of(context, rootNavigator: true).pop();
                      }
                    },
                    child: Text(DBString.standard_done, style: Theme.of(context).primaryTextTheme.button),
                  )
                ],
              ),
              body: _buildContent(context)
          );
        }
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
        Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(DBDimens.PaddingDefault),
          child: TextFormField(
            controller: _inputController,
            decoration: new InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: DBString.add_section_hint,
            ),
            textInputAction: TextInputAction.go,
          ),
        ),
        Divider(color: Colors.grey, height: 1),
        _buildIconSelector(context),
        Divider(color: Colors.grey, height: 1),
      ],
    );
  }

  Widget _buildIconSelector(BuildContext context){
    return InkWell(
      child: Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.all(DBDimens.PaddingDefault),
        child:
          new StreamBuilder(stream: _iconBloc.getSelectedIconStream(), builder: (context, AsyncSnapshot<DBIcon> snapshot){
            if(snapshot.hasData){
              var icon = snapshot.data;
              return Row(
                children: [
                  Icon(icon.mapToIcon, color: Theme.of(context).accentIconTheme.color),
                  SizedBox(width: DBDimens.PaddingDefault),
                  Expanded(child: Text(icon.name)),
                  Icon(Icons.chevron_right, color: Theme.of(context).accentIconTheme.color),
                ],
              );
            }
            return Container();
          })
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SelectIconPage()));
      },
    );
  }

}
