import 'dart:async';
import 'dart:developer';

import 'package:doce_blocks/data/models/block.dart';
import 'package:doce_blocks/domain/bloc/bloc.dart';
import 'package:doce_blocks/presentation/block/composer/add_block_page.dart';
import 'package:doce_blocks/presentation/block/draggableitem/draggable_item.dart';
import 'package:doce_blocks/presentation/components/floating_action_add.dart';
import 'package:doce_blocks/presentation/player/player_page.dart';
import 'package:doce_blocks/presentation/utils/cross_platform_svg.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        ));
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context) {
    return Container();
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CONTENT
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context) {
    return StreamBuilder(
        stream: _blocksBloc.getBlocksStream(),
        builder: (context, AsyncSnapshot<List<Block>> snapshot) {
          if (snapshot.hasData) {
            var blockList = snapshot.data;

            if (blockList.isNotEmpty) {
              return Container(
                  padding: EdgeInsets.all(DBDimens.PaddingDefault),
                  color: Theme.of(context).backgroundColor,
                  child: ListView.builder(
                      itemCount: blockList.length,
                      itemBuilder: (context, index) {
                        Block block = blockList[index];

                        switch (block.type) {
                          case BlockType.CARD:
                            CardBlock cardBlock = block as CardBlock;
                            return (cardBlock.size == CardSize.BIG) ? _buildCardBlock(context, cardBlock) : _buildSmallCardBlock(context, cardBlock);
                          default:
                            return Container();
                        }
                      }));
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
              flex: 7,
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
                        ));
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
                        case Type.LIST:
                          setState(() {
                            _isEditMode = false;
                          });
                          _floatingButtonController.add(false);

                          _blocksBloc.add(SyncDoceboCatalogEvent());

                          //TODO: call Docebo catalog
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => AddBlockPage()));
                          break;
                      }
                    });
                  },
                ),
              )),
          Divider(color: Colors.grey, height: 1),
          Expanded(
              flex: 3,
              child: Container(
                child: GridView.count(crossAxisCount: 2, childAspectRatio: 1.2 / 1.0, children: [
                  Container(child: DraggableItem(type: Type.ARTICLE, name: DBString.draggable_item_article)),
                  Container(child: DraggableItem(type: Type.LIST, name: DBString.draggable_item_list)),
                ]),
              ))
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          EMPTY SLATE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildEmptySlate(BuildContext context) {
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
        ));
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CARDS
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildCardBlock(BuildContext context, CardBlock cardBlock) {
    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayerPage(
                      url: cardBlock.url,
                    ))),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: DBDimens.PaddingHalf, bottom: DBDimens.PaddingHalf),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6.0),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/placeholder.png',
                  image: cardBlock.thumbUrl,
                  height: 174.0,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: DBDimens.PaddingDefault),
              Text(cardBlock.title, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline6),
              SizedBox(height: DBDimens.PaddingHalf),
              Text(cardBlock.description, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyText2),
              SizedBox(height: DBDimens.PaddingDefault),
              _buildCardFooter(context, cardBlock.uid),
              SizedBox(height: DBDimens.PaddingDefault),
              Divider(color: Colors.grey, height: 1),
            ],
          ),
        ));
  }

  Widget _buildSmallCardBlock(BuildContext context, CardBlock cardBlock) {
    return InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PlayerPage(
                      url: cardBlock.url,
                    ))),
        child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: DBDimens.PaddingHalf, bottom: DBDimens.PaddingHalf),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(cardBlock.title, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: Theme.of(context).textTheme.headline6),
                          SizedBox(height: DBDimens.PaddingHalf),
                          Text(cardBlock.description, maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.start, style: Theme.of(context).textTheme.bodyText2),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.png',
                        image: cardBlock.thumbUrl,
                        height: 75,
                        width: 75,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: DBDimens.PaddingDefault),
                  ],
                ),
                SizedBox(height: DBDimens.PaddingDefault),
                _buildCardFooter(context, cardBlock.uid),
                SizedBox(height: DBDimens.PaddingDefault),
                Divider(color: Colors.grey, height: 1),
              ],
            )));
  }

  Widget _buildCardFooter(BuildContext context, String blockId) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text("by Hairy-Hearts")),
        Icon(
          Icons.book,
          color: Colors.grey[400],
        ),
        SizedBox(width: DBDimens.PaddingHalf),
        InkWell(
          onTap: () {
            showModalBottomSheet(context: context, builder: (context) => _buildCardBottomSheet(context, blockId));
          },
          child: Icon(
            Icons.more_horiz,
            color: Colors.grey[400],
          ),
        )
      ],
    );
  }

  Widget _buildCardBottomSheet(BuildContext context, String blockId) {
    return Wrap(children: <Widget>[
      Container(
        child: Container(
          decoration: new BoxDecoration(color: Colors.white, borderRadius: new BorderRadius.only(topLeft: const Radius.circular(25.0), topRight: const Radius.circular(25.0))),
          child: SafeArea(
            child: Container(
              child: Column(
                children: [
                  _buildIconSelector(context, Icons.delete, DBString.standard_remove, () {
                    _blocksBloc.add(DeleteBlockEvent(blockId: blockId));
                    Navigator.of(context).pop();
                  }),
                  _buildIconSelector(context, Icons.close, DBString.standard_cancel, () => Navigator.of(context).pop()),
                ],
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Widget _buildIconSelector(BuildContext context, IconData icon, String text, VoidCallback onAction) {
    return InkWell(
      child: Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(DBDimens.PaddingDefault),
          child: Row(
            children: [
              Icon(icon, color: Colors.grey[400]),
              SizedBox(width: DBDimens.PaddingDefault),
              Expanded(child: Text(text)),
            ],
          )),
      onTap: onAction,
    );
  }
}
