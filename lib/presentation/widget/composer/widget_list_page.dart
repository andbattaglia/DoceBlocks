import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/image_drag_item.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/simple_drag_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WidgetListPage extends StatefulWidget {

  final bool isHorizontal;

  WidgetListPage({@required this.isHorizontal}) : super();

  @override
  _WidgetListPageState createState() => _WidgetListPageState();
}

class _WidgetListPageState extends State<WidgetListPage> {

  bool accepted = false;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
        mobile: _buildSmallPage(context),
        tablet: OrientationLayoutBuilder(
          portrait: (context) => _buildSmallPage(context),
          landscape: (context) => _buildLargePage(context),
        ),
        desktop: _buildLargePage(context)
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context){
    return Container(
      padding: EdgeInsets.only( left: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault, bottom: DBDimens.PaddingDouble),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              height: 72,
              child: _buildContent(context)
          )
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context){
    return Container(
      padding: EdgeInsets.only( top: DBDimens.PaddingDefault, bottom: DBDimens.PaddingDefault),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            width: 72,
            child: _buildContent(context)
          )
        ],
      ),
    );
  }


  Widget _buildContent(BuildContext context){
    return ListView(
      scrollDirection: widget.isHorizontal ? Axis.horizontal : Axis.vertical,
      children: <Widget>[
        _buildImageWidget(context),
        _buildImageWidget(context),
        _buildImageWidget(context),
      ],
    );
  }
}


Widget _buildImageWidget(BuildContext context) {

  var tile = ImageDragItem();

  return Draggable(
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
  );
}

