import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:flutter/material.dart';

class ImageDragItem extends StatelessWidget {
  final IconData icon;
  final Color color;

  const ImageDragItem({@required this.icon, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 72,
      child: Card(
          elevation: 4.0,
          child: Container(
            padding: EdgeInsets.all(DBDimens.PaddingDefault),
            child: Icon(this.icon, size: 24, color: this.color),
          )),
    );
  }
}
