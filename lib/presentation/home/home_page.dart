import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/domain/bloc/theme/settings_theme_bloc.dart';
import 'package:doce_blocks/presentation/drawer/drawer_menu.dart';
import 'package:doce_blocks/presentation/profile/profile_page.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/themes.dart';
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
            _buildProfileAvatar(context)
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
                child: Text('${state.user.name[0]}${state.user.lastName[0]}', style: Theme.of(context).textTheme.headline6),
              ),
            ),
          );
        }
        return null;
      },
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