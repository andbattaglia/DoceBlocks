import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PlayerPage extends StatefulWidget {
  final String url;

  PlayerPage({@required this.url}) : super();

  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: _buildSmallPage(context),
      tablet: OrientationLayoutBuilder(
        portrait: (context) => _buildSmallPage(context),
        landscape: (context) => _buildSmallPage(context),
      ),
      desktop: _buildSmallPage(context),
    );
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          SMALL PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildSmallPage(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          iconTheme: Theme.of(context).accentIconTheme,
          title: Text(DBString.player_title,
              style: Theme.of(context).textTheme.headline6),
          elevation: 0.0,
        ),
        body: _buildContent(context));
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CONTENT
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context) {
    return EasyWebView(
      src: widget.url,
      onLoaded: () {},
      isHtml: false,
      isMarkdown: false,
    );
  }
}
