import 'package:doce_blocks/presentation/widget/draggableitem/image_drag_item.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/simple_drag_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WidgetListPage extends StatefulWidget {
  @override
  _WidgetListPageState createState() => _WidgetListPageState();
}

class _WidgetListPageState extends State<WidgetListPage> {

  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          _buildSimpleWidget(context),
          _buildSimpleWidget(context),
          _buildImageWidget(context),
          _buildImageWidget(context),
          _buildImageWidget(context),
        ],
      ),
    );
  }
}

Widget _buildSimpleWidget(BuildContext context) {

  var tile = SimpleDragItem();

  return Container(
    child: Draggable(
      data: 'Flutter_Simple',
      child: tile,
      feedback: tile,
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: tile,
      ),
      onDragCompleted: () {},
      onDragEnd: (drag) {
      },
    ),
  );
}

Widget _buildImageWidget(BuildContext context) {

  var tile = ImageDragItem();

  return Container(
    child: Draggable(
      data: 'Flutter_Image',
      child: tile,
      feedback: tile,
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: tile,
      ),
      onDragCompleted: () {},
      onDragEnd: (drag) {
      },
    ),
  );
}

