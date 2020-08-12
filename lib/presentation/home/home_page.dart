import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/presentation/drawer/drawer_menu.dart';
import 'package:doce_blocks/presentation/profile/profile_page.dart';
import 'package:doce_blocks/presentation/utils/colors.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerMenu(),
        appBar: AppBar(
          title: Text(DBString.title),
          actions: <Widget>[
            _buildProfile(context)
          ],
        ),
        body: _buildBody()
    );
  }

  Widget _buildBody() {

//    double top = 0;
//    double left = 0;
//
//    return Container(
//      child: Draggable(
//        //TODO: START
//        child: Container(
//          padding: EdgeInsets.only(top: top, left: left),
//          child: DragItem(),
//        ),
//        //TODO: THE DRAGGABLE ICON
//        feedback: Container(
//          padding: EdgeInsets.only(top: top, left: left),
//          child: DraggingItem(),
//        ),
//        //TODO: START ICON DURING DRAGGING
//        childWhenDragging: Container(
//          padding: EdgeInsets.only(top: top, left: left),
//          child: DragItem(),
//        ),
//        onDragCompleted: () {},
//        onDragEnd: (drag) {
//        },
//      ),
//    );
  }

  Widget _buildProfile(BuildContext context){
    return Container(
      child: GestureDetector(
        onTap: () {
          showDialog(context: context, builder: (BuildContext context) => ProfilePage(),
          );        },
        child:  CircleAvatar(
          backgroundColor: DBColors.PrimaryColor,
          child: Text('AH'),
        ),
      ),
    );
  }
}


//TODO: draggable item
//class DragItem extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Icon(
//      Icons.audiotrack,
//      color: Colors.green,
//      size: 30.0,
//    );
//  }
//}
//
//class DraggingItem extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Icon(
//      Icons.beach_access,
//      color: Colors.blue,
//      size: 36.0,
//    );
//  }
//}