import 'package:doce_blocks/presentation/utils/cross_platform_svg.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DraggableItem extends StatelessWidget {
  final Type type;
  final String name;

  DraggableItem({@required this.type, @required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 210, //TODO: to calculate
        height: 170, //TODO: to calculate
        padding: EdgeInsets.only(
            left: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                padding: EdgeInsets.all(DBDimens.PaddingDefault),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0xFFdfe4e8))),
                child: _buildDraggableTile(context)),
            SizedBox(height: DBDimens.PaddingHalf),
            Text(name,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6),
          ],
        ));
  }

  Widget _buildDraggableTile(BuildContext context) {
    var tile = CrossPlatformSvg.asset(_mapIcon(), width: 72, height: 72);

    return Draggable(
      data: type.tag,
      child: tile,
      feedback: tile,
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: tile,
      ),
      onDragCompleted: () {},
      onDragEnd: (drag) {},
    );
  }

  String _mapIcon() {
    switch (type) {
      case Type.LIST:
        return 'assets/icon_list.png';
      default:
        return 'assets/icon_article.png';
    }
  }
}

enum Type { get, ARTICLE, VIDEO, LIST }

extension TypeString on Type {
  String get tag => describeEnum(this);
  operator [](String key) => (name) {
        switch (name) {
          case 'ARTICLE':
            return Type.ARTICLE;
          case 'LIST':
            return Type.LIST;
          case 'VIDEO':
            return Type.VIDEO;
          default:
            throw RangeError("enum TypeString contains no value '$name'");
        }
      }(key);
}
