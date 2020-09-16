import 'dart:async';
import 'dart:developer';

import 'package:doce_blocks/data/models/block.dart';
import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/presentation/block/composer/add_block_page.dart';
import 'package:doce_blocks/presentation/block/draggableitem/draggable_item.dart';
import 'package:doce_blocks/presentation/components/floating_action_add.dart';
import 'package:doce_blocks/presentation/utils/cross_platform_svg.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class BlockComposerPage extends StatefulWidget {
  @override
  _BlockComposerPageState createState() => _BlockComposerPageState();
}

class _BlockComposerPageState extends State<BlockComposerPage> {

  bool _isEditMode = false;
  StreamController<bool> _floatingButtonController = StreamController<bool>();

  BlocksBloc _blocksBloc;

  @override
  void initState() {
    _blocksBloc = new BlocksBloc();
  }

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
          },
          stream: _floatingButtonController.stream,
      ),
      body: SafeArea(
        child: _isEditMode ? _buildEditMode(context) : _buildContent(context),
      )
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context) {
    return Container();
  }

  Widget _buildContent(BuildContext context) {

    return StreamBuilder(
        stream: _blocksBloc.getBlocksStream(),
        builder: (context, AsyncSnapshot<List<Block>> snapshot) {
          if (snapshot.hasData) {
            var blockList = snapshot.data;

            if(blockList.isNotEmpty){
              return Container(
                padding: EdgeInsets.all(DBDimens.PaddingDefault),
                color: Theme.of(context).backgroundColor,
                child: ListView.builder(
                    itemCount: blockList.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.lightBlueAccent,
                          child: InkWell(
                            splashColor: Colors.blue.withAlpha(30),
                            onTap: () {},
                            child: Container(
                              width: 300,
                              height: 100,
                              child: Text(blockList[index].uid),
                            ),
                          )
                      );
                    })
              );
            } else {
              return _buildEmptySlate(context);
            }
          }

          return Container();
        });
  }

  Widget _buildEditMode(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
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
                          CrossPlatformSvg.asset('assets/empty_slate.svg'),
                          SizedBox(height: DBDimens.PaddingDefault),
                          Text(DBString.composer_drag_drop_description, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1),
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
                    switch (Type.get[data]) {
                      case Type.ARTICLE:
                        setState(() {
                          _isEditMode = false;
                        });
                        _floatingButtonController.add(false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddBlockPage()));
                        break;
                      case Type.VIDEO:
                        setState(() {
                          _isEditMode = false;
                        });
                        _floatingButtonController.add(false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddBlockPage()));
                        break;
                      case Type.LIST:
                        setState(() {
                          _isEditMode = false;
                        });
                        _floatingButtonController.add(false);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AddBlockPage()));
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
                  Container(child: DraggableItem(type: Type.ARTICLE, name: DBString.draggable_item_article)),
                  Container(child: DraggableItem(type: Type.LIST, name: DBString.draggable_item_list)),
                  Container(child: DraggableItem(type: Type.VIDEO, name: DBString.draggable_item_video))
                ]
              ),
            )
          )
        ],
      ),
    );
  }

  Widget _buildEmptySlate(BuildContext context){
    return Container(
        color: Theme.of(context).backgroundColor,
        padding: EdgeInsets.only(left: DBDimens.Padding50, right: DBDimens.Padding50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(DBString.composer_empty_slate_title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline4),
            SizedBox(height: DBDimens.PaddingDouble),
            CrossPlatformSvg.asset('assets/empty_slate_section.svg', height: 180, width: 180),
            SizedBox(height: DBDimens.PaddingDouble),
            Text(DBString.composer_empty_slate_description, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyText1),
          ],
        )
    );
  }
}
