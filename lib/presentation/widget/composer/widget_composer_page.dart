import 'dart:developer';

import 'package:doce_blocks/presentation/widget/composer/widget_list_page.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/image_drag_item.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/simple_drag_item.dart';
import 'package:flutter/material.dart';

class WidgetComposerPage extends StatefulWidget {
  @override
  _WidgetComposerPageState createState() => _WidgetComposerPageState();
}

class _WidgetComposerPageState extends State<WidgetComposerPage> {

  List<Widget> itemsList = [];

  @override
  Widget build(BuildContext context) {

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
}