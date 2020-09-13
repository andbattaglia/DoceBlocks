import 'dart:developer';

import 'package:doce_blocks/domain/bloc/pages/pages_bloc.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/widget/composer/widget_list_page.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/image_drag_item.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/simple_drag_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WidgetComposerPage extends StatefulWidget {
  @override
  _WidgetComposerPageState createState() => _WidgetComposerPageState();
}

class _WidgetComposerPageState extends State<WidgetComposerPage> {

  List<Widget> itemsList = [];

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

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context){
    return Scaffold(
      floatingActionButton: AddFloatingActionButton(),
      body: _buildContent(context),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: DBDimens.PaddingDefault, bottom: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(DBDimens.CornerDefault),
      ),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(flex: 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).selectedRowColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(DBDimens.CornerDefault), bottomLeft: Radius.circular(DBDimens.CornerDefault)),
                    ),
                  )
              ),
              Expanded(flex: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).selectedRowColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(DBDimens.CornerDefault), bottomRight: Radius.circular(DBDimens.CornerDefault)),
                    ),
                    child: WidgetListPage(isHorizontal: false),
                  )
              )
            ],
          ),
          Row(
            children: [
              Expanded(flex: 9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
                    ),
                    child: _buildContent(context),
                  )
              ),
              Expanded(flex: 1,
                  child: Container()
              )
            ],
          ),
        ],
      )
    );
  }


  Widget _buildContent(BuildContext context){

    PagesBloc _counterBloc = new PagesBloc();

    return BlocBuilder<PagesBloc, PagesState>(
        builder: (context, state) {
          if(state is GetPagesSuccess){

            var pagesList = state.pages;

//            return Container(
//              child: new StreamBuilder(stream: _counterBloc.counterObservable, builder: (context, AsyncSnapshot<int> snapshot){
//                return new Text('${snapshot.data}', style: Theme.of(context).textTheme.display1);
//              })
//            );


            return Container();

          }

          return Container();
        }
    );


    return Container(
      child: DragTarget(
        builder: (context, List<String> candidateData, rejectedData) {
          if(itemsList.length > 0){

            return ListView.builder(
                itemCount: itemsList.length,
                itemBuilder: (context, index) {
                  return itemsList[index];
                });

          } else {
            return Container();
          }
        },
        onWillAccept: (data) {
          return true;
        },
        onAccept: (data) {
          setState(() {
            switch(data){
              case "Flutter_Image":
                itemsList.add(ImageDragItem());
                break;
              case "Flutter_Simple":
                itemsList.add(SimpleDragItem());
                break;
            }
            var deviceType = getDeviceType(MediaQuery.of(context).size);
            if(deviceType == DeviceScreenType.mobile) {
              Navigator.of(context).pop();
            }
          });
        },
      ),
    );
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//          FLOATING BUTTON
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
class AddFloatingActionButton extends StatefulWidget {

  @override
  _AddFloatingActionButtonState createState() => _AddFloatingActionButtonState();
}

class _AddFloatingActionButtonState extends State<AddFloatingActionButton> {

  bool isOpen = false;
  PersistentBottomSheetController bottomSheetController;

  @override
  Widget build(BuildContext context) {

    if(isOpen){
      return FloatingActionButton(
        backgroundColor: Colors.red,
        child: Icon(Icons.close),
        onPressed: () {
          bottomSheetController.close();
          changeState(false);
        },
      );
    } else {
      return FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor ,
          child: Icon(Icons.add),
          onPressed: () {
            bottomSheetController = showBottomSheet(
                context: context,
                builder: (context) => Container(
                  constraints: BoxConstraints.expand(height: 150),
                  color: Theme.of(context).selectedRowColor,
                  child: WidgetListPage(isHorizontal: true),
                )
            );
            changeState(true);
            bottomSheetController.closed.then((value) {
              changeState(false);
            });
          });
    }
  }

  void changeState(bool value) {
    setState(() {
      isOpen = value;
    });
  }
}