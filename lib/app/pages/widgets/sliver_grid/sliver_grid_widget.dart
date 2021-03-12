import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_studioh/app/network/network_const.dart';
import 'package:news_studioh/app/utils/function_util.dart';

class SliverGridWidget extends StatelessWidget {
  final List list;

  const SliverGridWidget({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var gridItems = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      var d = list[i];
      gridItems.add(Container(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        height: 500,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Modular.to.pushNamed(
                  '/detail',
                  arguments: d,
                );
              },
              child: Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.fromLTRB(3, 6, 3, 0),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(9),
                    image: DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(d.urlToImage ?? urlPng))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Spacer(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(9),
                          bottomRight: Radius.circular(9),
                        ),
                      ),
                      child: Text(
                        d.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Colors.grey,
                            ),
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 8.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              width: 150,
              child:
                Text(
                  '${FunctionUtil.formatDate(d.publishedAt)}\n${d.source.name}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 10, color: Colors.grey.shade700),
                ),
            ),
          ],
        ),
      ));
    }
    return SliverGrid.count(
      children: gridItems,
      crossAxisCount: 2,
    );
  }
}
