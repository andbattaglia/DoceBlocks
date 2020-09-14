import 'package:flutter/material.dart';

class FloatingActionAdd extends StatefulWidget {

  final VoidCallback onAdd;
  final VoidCallback onClose;

  FloatingActionAdd({@required this.onAdd, @required this.onClose}) : super();

  @override
  _FloatingActionAddState createState() => _FloatingActionAddState();
}

class _FloatingActionAddState extends State<FloatingActionAdd> {
  bool isOpen = false;
//  PersistentBottomSheetController bottomSheetController;

  @override
  Widget build(BuildContext context) {
    if (isOpen) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.close),
        onPressed: () {
          widget.onClose();
          changeState(false);
        },
      );
    } else {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          widget.onAdd();
          changeState(true);
        },
      );
//      return FloatingActionButton(
//          backgroundColor: Theme.of(context).primaryColor,
//          child: Icon(Icons.add),
//          onPressed: () {
//            bottomSheetController = showBottomSheet(
//                context: context,
//                builder: (context) => Container(
//                  constraints: BoxConstraints.expand(height: 150),
//                  color: Theme.of(context).selectedRowColor,
//                  child: WidgetListPage(isHorizontal: true),
//                ));
//            changeState(true);
//            bottomSheetController.closed.then((value) {
//              changeState(false);
//            });
//          });
    }
  }

  void changeState(bool value) {
    setState(() {
      isOpen = value;
    });
  }
}