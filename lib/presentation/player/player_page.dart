import 'dart:async';

import 'package:doce_blocks/presentation/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
  //          LARGE PAGE
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildLargePage(BuildContext context) {
    return Container();
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  //          CONTENT
  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildContent(BuildContext context) {
    final Completer<WebViewController> _controller =
        Completer<WebViewController>();

    return WebView(
      initialUrl: widget.url,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) {
        _controller.complete(webViewController);
      },
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith('https://www.youtube.com/')) {
          return NavigationDecision.prevent;
        }
        return NavigationDecision.navigate;
      },
      onPageStarted: (String url) {
        print('Page started loading: $url');
      },
      onPageFinished: (String url) {
        print('Page finished loading: $url');
      },
      gestureNavigationEnabled: true,
    );
  }
}
