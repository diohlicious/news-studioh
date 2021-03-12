import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_studioh/app/network/network_const.dart';
import 'package:news_studioh/app/pages/home/home_model/news_model.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:news_studioh/app/utils/function_util.dart';

class DetailPage extends StatelessWidget {
  final Article article;

  DetailPage({
    Key key,
    this.article,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    GlobalKey globalKey=GlobalKey();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0x00000000),
        elevation: 1,
        title: Text(article.source.name),
      ),
      body: Builder(
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment(3.0, 0.3),
              // 10% of the width, so there are ten blinds.
              colors: [Colors.white, Colors.brown[500]],
              // red to yellow
              tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
            ),
          ),
          child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  RepaintBoundary(
                    key:globalKey,
                    child: Container(
                      color: Colors.white,
                      padding: EdgeInsets.only(bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(article.urlToImage??urlPng),
                              ),
                            ),
                          ),
                          Text(
                            article.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Divider(),
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                    style: TextStyle(color: Colors.grey.shade800),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: '${FunctionUtil.formatDate(article.publishedAt)}, ${article.source.name}-${article.author}\n\n',
                                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey.shade700)
                                      ),
                                      TextSpan(
                                        text: '${article.description} '
                                      ),
                                      TextSpan(
                                          text: 'Read More',
                                          style: TextStyle(decoration: TextDecoration.underline,),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Modular.to.pushNamed('/webview', arguments: article);
                                            })
                                    ]),),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Container(
                      alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Text('SHARE')),
                    onPressed: ()async{
                      RenderRepaintBoundary imageObject = globalKey.currentContext.findRenderObject();
                      final image = await imageObject.toImage(pixelRatio: 2.0);
                      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
                      Uint8List pngBytes = byteData.buffer.asUint8List();
                      await Share.file('share', 'image.png', pngBytes, 'image/png', text: article.url);

                    },
                  )
                ],
              ),
          ),
        ),
      );
  }
}
