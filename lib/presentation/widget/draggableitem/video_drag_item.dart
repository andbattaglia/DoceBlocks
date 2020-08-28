import 'package:flutter/material.dart';
import 'package:doce_blocks/components/simple_video.dart';

class VideoDragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 10.0,
        height: 190.0,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: SimpleVideo());
  }
}
