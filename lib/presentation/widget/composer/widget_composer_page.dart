import 'dart:developer';

import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/widget/composer/widget_list_page.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/image_drag_item.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/simple_drag_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WidgetComposerPage extends StatefulWidget {
  @override
  _WidgetComposerPageState createState() => _WidgetComposerPageState();
}

class _WidgetComposerPageState extends State<WidgetComposerPage> {

  List<Widget> itemsList = [];

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _buildSmallPage(context),
        tablet: OrientationLayoutBuilder(
          portrait: (context) => _buildSmallPage(context),
          landscape: (context) => _buildLargePage(context),
        ),
        desktop: _buildLargePage(context)
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
          });
        },
      ),
    );
  }

  Widget _buildSmallPage(BuildContext context){
    return Container(

    );
  }

  Widget _buildLargePage(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: DBDimens.PaddingDefault, bottom: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(DBDimens.CornerDefault),
      ),
    );
  }
}