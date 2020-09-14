import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:flutter/material.dart';

class DraggableItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    var tile = _buildContent(context);

    return Draggable(
      data: 'DRAGGABLE_ITEM',
      child: tile,
      feedback: tile,
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: tile,
      ),
      onDragCompleted: () {},
      onDragEnd: (drag) {
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      width: 210,
      height: 170,
      padding: EdgeInsets.only(left: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(DBDimens.PaddingDefault),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Color(0xFFdfe4e8))
            ),
            child: Container(
              width: 72,
              height: 72,
              child: Icon(Icons.wb_sunny, size: 55),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFdfe4e8)),
            )
          ),
          SizedBox(height: DBDimens.PaddingHalf),
          Text("Title", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6),
        ],
      )
    );
  }
}
