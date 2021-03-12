import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_studioh/app/network/network_const.dart';
import 'package:news_studioh/app/utils/function_util.dart';

class SliverListWidget extends StatelessWidget {
  final List list;

  const SliverListWidget({Key key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var listItems = <Widget>[];
    for (var i = 0; i < list.length; i++) {
      var d = list[i];
      listItems.add(
        GestureDetector(
          onTap: (){Modular.to.pushNamed('/detail', arguments: d, );
            },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            margin: EdgeInsets.fromLTRB(3, 5, 3, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(
                    3.0, 0.3), // 10% of the width, so there are ten blinds.
                colors: [Colors.white, Colors.brown[900], ], // red to yellow
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 120,
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        fit: BoxFit.fitWidth,
                        image: NetworkImage(
                            d.urlToImage??urlPng),
                      )),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  padding: EdgeInsets.fromLTRB(5, 12, 5, 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(
                          3.0, 0.3), // 10% of the width, so there are ten blinds.
                      colors: [Colors.white.withOpacity(0.0), Colors.white.withOpacity(0.5), ], // red to yellow
                      tileMode:
                      TileMode.repeated, // repeats the gradient over the canvas
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${FunctionUtil.formatDate(d.publishedAt)} ${d.source.name}',
                        style: TextStyle(color: Colors.grey.shade700,
                          fontSize: 12
                        ),
                      ),
                      Text(
                        d.title,
                        style: TextStyle(color: Colors.grey.shade700,
                        ),
                      ),
                      Text('${d.description}',
                          style: TextStyle(color: Colors.brown[900], fontSize: 12),overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return SliverList(
      delegate: SliverChildListDelegate(listItems),
    );
  }
}
