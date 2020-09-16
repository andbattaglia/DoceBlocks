import 'package:flutter/material.dart';

class FloatingActionAdd extends StatefulWidget {

  final Stream<bool> stream;

  final VoidCallback onAdd;
  final VoidCallback onClose;

  FloatingActionAdd({@required this.onAdd, @required this.onClose, this.stream}) : super();

  @override
  _FloatingActionAddState createState() => _FloatingActionAddState();
}

class _FloatingActionAddState extends State<FloatingActionAdd> {

  bool isOpen = false;

  @override
  void initState() {
    super.initState();
    widget.stream.listen((value) {
      _changeState(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isOpen) {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.close),
        onPressed: () {
          widget.onClose();
          _changeState(false);
        },
      );
    } else {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: () {
          widget.onAdd();
          _changeState(true);
        },
      );
    }
  }

  void _changeState(bool value) {
    setState(() {
      isOpen = value;
    });
  }
}