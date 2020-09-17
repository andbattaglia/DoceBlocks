import 'package:doce_blocks/data/models/models.dart';
import 'package:doce_blocks/domain/bloc/blocks/blocks_bloc.dart';
import 'package:doce_blocks/domain/bloc/sections/sections_bloc.dart';
import 'package:doce_blocks/presentation/block/composer/select_card_props_page.dart';
import 'package:doce_blocks/presentation/dbicon/select_icon_page.dart';
import 'package:doce_blocks/presentation/utils/dimens.dart';
import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';

class AddBlockPage extends StatefulWidget {
  @override
  _AddBlockPageState createState() => _AddBlockPageState();
}

class _AddBlockPageState extends State<AddBlockPage> {
  final _inputTitleController = TextEditingController();
  final _inputDescriptionController = TextEditingController();
  final _inputUrlController = TextEditingController();
  final _inputThumbUrlController = TextEditingController();

  BlocksBloc _blockBloc;

  @override
  void initState() {
    super.initState();
    _blockBloc = new BlocksBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BlocksBloc>(
      create: (_) => BlocksBloc(),
      child: ScreenTypeLayout(
        mobile: _buildSmallPage(context),
        tablet: OrientationLayoutBuilder(
          portrait: (context) => _buildSmallPage(context),
          landscape: (context) => _buildLargePage(context),
        ),
        desktop: _buildLargePage(context),
      ),
    );
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context) {
    return BlocBuilder<BlocksBloc, BlocksState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            iconTheme: Theme.of(context).accentIconTheme,
            title: Text(DBString.add_block_article_title,
                style: Theme.of(context).textTheme.headline6),
            elevation: 0.0,
            actions: [
              FlatButton(
                onPressed: () {
                  final url = _inputUrlController.text.trim();
                  final title = _inputTitleController.text.trim();
                  final description = _inputDescriptionController.text.trim();
                  final thumbUrl = _inputThumbUrlController.text.trim();

                  if (url.isNotEmpty &&
                      title.isNotEmpty &&
                      description.isNotEmpty &&
                      thumbUrl.isNotEmpty) {
                    BlocProvider.of<BlocksBloc>(context).add(
                      AddCardBlockEvent(
                        block: CardBlock(
                          url: url,
                          title: title,
                          description: description,
                          thumbUrl: thumbUrl,
                          sections: [],
                        ),
                      ),
                    );

                    Navigator.of(context, rootNavigator: true).pop();
                  } else {
                    //TODO: error?
                  }
                },
                child: Text(DBString.standard_add,
                    style: Theme.of(context).primaryTextTheme.button),
              )
            ],
          ),
          body: _buildContent(context));
    });
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context) {
    return Container();
  }

  ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CONTENT
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Divider(color: Colors.grey, height: 1),
        Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(DBDimens.PaddingDefault),
          child: TextFormField(
            controller: _inputTitleController,
            decoration: new InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: DBString.add_block_title_hint,
            ),
            textInputAction: TextInputAction.go,
          ),
        ),
        Divider(color: Colors.grey, height: 1),
        Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(DBDimens.PaddingDefault),
          child: TextFormField(
            controller: _inputDescriptionController,
            decoration: new InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: DBString.add_block_description_hint,
            ),
            textInputAction: TextInputAction.go,
          ),
        ),
        Divider(color: Colors.grey, height: 1),
        Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(DBDimens.PaddingDefault),
          child: TextFormField(
            controller: _inputUrlController,
            decoration: new InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: DBString.add_block_url_hint,
            ),
            textInputAction: TextInputAction.go,
          ),
        ),
        Divider(color: Colors.grey, height: 1),
        Container(
          color: Theme.of(context).backgroundColor,
          padding: EdgeInsets.all(DBDimens.PaddingDefault),
          child: TextFormField(
            controller: _inputThumbUrlController,
            decoration: new InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: DBString.add_block_thumb_hint,
            ),
            textInputAction: TextInputAction.go,
          ),
        ),
        Divider(color: Colors.grey, height: 1),
        _buildIconSelector(context),
        Divider(color: Colors.grey, height: 1),
      ],
    );
  }

  Widget _buildIconSelector(BuildContext context) {
    return StreamBuilder(
        stream: _blockBloc.getSelectedCardSizeStream(),
        builder: (context, AsyncSnapshot<CardSize> snapshot) {
          if (snapshot.hasData) {
            var cardSize = snapshot.data;

            switch (cardSize) {
              case CardSize.BIG:
                return InkWell(
                  child: Container(
                      color: Theme.of(context).backgroundColor,
                      padding: EdgeInsets.all(DBDimens.PaddingDefault),
                      child: Row(
                        children: [
                          Icon(Icons.filter,
                              color: Theme.of(context).accentIconTheme.color),
                          SizedBox(width: DBDimens.PaddingDefault),
                          Expanded(child: Text(cardSize.tag)),
                          Icon(Icons.chevron_right,
                              color: Theme.of(context).accentIconTheme.color),
                        ],
                      )),
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectCardPropsPage()));
                  },
                );
              default:
                return InkWell(
                  child: Container(
                      color: Theme.of(context).backgroundColor,
                      padding: EdgeInsets.all(DBDimens.PaddingDefault),
                      child: Row(
                        children: [
                          Icon(Icons.filter,
                              color: Theme.of(context).accentIconTheme.color),
                          SizedBox(width: DBDimens.PaddingDefault),
                          Expanded(child: Text(cardSize.tag)),
                          Icon(Icons.chevron_right,
                              color: Theme.of(context).accentIconTheme.color),
                        ],
                      )),
                  onTap: () async {
                    await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelectCardPropsPage()));
                  },
                );
            }
          }
          return Container();
        });
  }
}
