import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:flutter/material.dart';

class ImageDragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4.0,
        child: Container(
          padding: EdgeInsets.all(DBDimens.PaddingDefault),
          child: FlutterLogo(
            size: 24,
          ),
        )
    );
  }
}
