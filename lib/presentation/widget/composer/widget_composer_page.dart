import 'package:doce_blocks/presentation/components/floating_action_add.dart';
import 'package:doce_blocks/presentation/utils/cross_platform_svg.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:doce_blocks/presentation/widget/draggableitem/draggable_item.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class WidgetComposerPage extends StatefulWidget {
  @override
  _WidgetComposerPageState createState() => _WidgetComposerPageState();
}

class _WidgetComposerPageState extends State<WidgetComposerPage> {

  bool _isEditMode = false;

  List<Widget> itemsList = [];

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _buildSmallPage(context),
      tablet: OrientationLayoutBuilder(
        portrait: (context) => _buildSmallPage(context),
        landscape: (context) => _buildLargePage(context),
      ),
      desktop: _buildLargePage(context),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionAdd(
          onAdd: () {
            setState(() {
              _isEditMode = true;
            });
          },
          onClose: () {
            setState(() {
              _isEditMode = false;
            });
          }),
      body: _isEditMode ? _buildEditMode(context) : _buildContent(context),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context) {
    return Container();
//    return Container(
//        margin: EdgeInsets.only(top: DBDimens.PaddingDefault, bottom: DBDimens.PaddingDefault, right: DBDimens.PaddingDefault),
//        decoration: BoxDecoration(
//          color: Theme.of(context).backgroundColor,
//          borderRadius: BorderRadius.circular(DBDimens.CornerDefault),
//        ),
//        child: Stack(
//          children: [
//            Row(
//              children: [
//                Expanded(
//                    flex: 9,
//                    child: Container(
//                      decoration: BoxDecoration(
//                        color: Theme.of(context).selectedRowColor,
//                        borderRadius: BorderRadius.only(topLeft: Radius.circular(DBDimens.CornerDefault), bottomLeft: Radius.circular(DBDimens.CornerDefault)),
//                      ),
//                    )),
//                Expanded(
//                    flex: 1,
//                    child: Container(
//                      decoration: BoxDecoration(
//                        color: Theme.of(context).selectedRowColor,
//                        borderRadius: BorderRadius.only(topRight: Radius.circular(DBDimens.CornerDefault), bottomRight: Radius.circular(DBDimens.CornerDefault)),
//                      ),
//                      child: WidgetListPage(isHorizontal: false),
//                    ))
//              ],
//            ),
//            Row(
//              children: [
//                Expanded(
//                    flex: 9,
//                    child: Container(
//                      decoration: BoxDecoration(
//                        color: Theme.of(context).backgroundColor,
//                        borderRadius: BorderRadius.all(Radius.circular(DBDimens.CornerDefault)),
//                      ),
//                      child: _buildContent(context),
//                    )),
//                Expanded(flex: 1, child: Container())
//              ],
//            ),
//          ],
//        ));
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      child: Text("CONTENT"),
    );
//    return Container(
//      child: DragTarget(
//        builder: (context, List<String> candidateData, rejectedData) {
//          if (itemsList.length > 0) {
//            return ListView.builder(
//                itemCount: itemsList.length,
//                itemBuilder: (context, index) {
//                  return itemsList[index];
//                });
//          } else {
//            return Container();
//          }
//        },
//        onWillAccept: (data) {
//          return true;
//        },
//        onAccept: (data) {
//          setState(() {
//            switch (data) {
//              case "DRAGGABLE_ITEM":
//                itemsList.add(DraggableItem());
//                break;
//            }
//            var deviceType = getDeviceType(MediaQuery.of(context).size);
//            if (deviceType == DeviceScreenType.mobile) {
//              Navigator.of(context).pop();
//            }
//          });
//        },
//      ),
//    );
  }

  Widget _buildEditMode(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [

          Expanded(
            flex: 6,
            child: Container(
              child: DragTarget(
                builder: (context, List<String> candidateData, rejectedData) {
                  return Container(
                      padding: EdgeInsets.only(left: DBDimens.Padding50, right: DBDimens.Padding50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CrossPlatformSvg.asset('assets/logo.svg'),
                          SizedBox(height: DBDimens.PaddingHalf),
                          Text(DBString.composer_description, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline5),
                          SizedBox(
                            height: DBDimens.Padding50,
                          ),
                        ],
                      )
                  );
                },
                onWillAccept: (data) {
                  return true;
                },
                onAccept: (data) {
                  setState(() {
                    switch (data) {
                      case "DRAGGABLE_ITEM":
                        Scaffold.of(context).showSnackBar(const SnackBar(content: Text('Drag and Drop Successfully'),));
                        break;
                    }
                  });
                },
              ),
            )
          ),

          Divider(color: Colors.grey, height: 1),

          Expanded(
            flex: 5,
            child: Container(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1.2 / 1.0,
                children: [
                  Container(child: DraggableItem()),
                  Container(child: DraggableItem()),
                  Container(child: DraggableItem())
                ]
              ),
            )
          )
        ],
      ),
    );
  }
}
