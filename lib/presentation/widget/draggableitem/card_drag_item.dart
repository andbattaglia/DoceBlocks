import 'dart:math';

import 'package:flutter/material.dart';

import 'package:doce_blocks/components/simple_card.dart';

class CardDragItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleCard(
            title: "This is a title for card",
            content: "this is the content",
            color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
            image:
                "https://www.expartibus.it/wp-content/uploads/2017/08/panorami.jpg"));
  }
}
