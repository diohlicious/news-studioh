
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:news_studioh/app/pages/home/home_model/news_model.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewPage extends StatefulWidget {
  final Article article;
  const WebviewPage({Key key, this.article}):super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();

}

  class _WebviewPageState extends State<WebviewPage>{

    @override
    void initState() {
      super.initState();
      if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x00000000),
        elevation: 1,
        title: Text(widget.article.title),
      ),
      body: WebView(
        initialUrl: widget.article.url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
