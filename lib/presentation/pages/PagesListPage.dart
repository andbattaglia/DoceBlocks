import 'package:flutter/material.dart';

class PagesListPage extends StatefulWidget {
  @override
  _PagesListPageState createState() => _PagesListPageState();
}

class _PagesListPageState extends State<PagesListPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: ListView(
        children: <Widget>[
          ListTile(title: Text("Page 1")),
        ],
      )
    );
  }
}
