import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_studioh/app/pages/home/home_bloc.dart';
import 'package:news_studioh/app/pages/widgets/sliver_grid/sliver_grid_widget.dart';
import 'package:news_studioh/app/pages/widgets/sliver_list/sliver_list_widget.dart';

import 'home_model/news_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage>{
  HomeBloc bloc;
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    bloc = Modular.get<HomeBloc>();
    bloc.fetchNews();
    _controller = TextEditingController(
      text: bloc.txtSearch,
    );
  }

  bool _switchList = true;

  bool get switchList => _switchList;

  setSwitchList() {
    setState(() {
      _switchList = !switchList;
    });
  }

  bool _isSearch = false;

  bool get isSearch => _isSearch;

  setIsSearch() {
    setState(() {
    _isSearch = !isSearch;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Article>>
      (
      stream: bloc.article$,
      builder: (context,snapshot){
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        var d = snapshot.data;
        return
        Scaffold(
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.3, 3.0),
                    colors: [Colors.white, Colors.brown[900]],
                  )),
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.black.withOpacity(0.0),
                    expandedHeight: !isSearch ? 120 : 0,
                    stretch: true,
                    pinned: true,
                    elevation: 0,
                    stretchTriggerOffset: 150,
                    flexibleSpace: FlexibleSpaceBar(
                      title: Row(
                        children: [
                          !isSearch ?
                          Text(
                            '',
                            style: TextStyle(color: Colors.white),
                          ): Container(
                            width: MediaQuery.of(context).size.width / 2,
                            child: TextField(
                                controller: _controller,
                                onChanged: bloc.setTxtSearch,
                                onSubmitted: (value) {
                                  bloc.fetchNews();
                                },
                                textInputAction: TextInputAction.search,
                                decoration: new InputDecoration(
                                    prefixIcon: new Icon(Icons.search),
                                    hintText: 'Search...')),
                          )
                          ,
                          Spacer(),
                          IconButton(
                            icon: Icon(CupertinoIcons.search_circle_fill),
                            color: Colors.white,
                            iconSize: 15,
                            onPressed: () {
                              setIsSearch();
                            },
                          ),
                          IconButton(
                            icon: switchList
                                ? Icon(CupertinoIcons.rectangle_grid_2x2_fill)
                                : Icon(CupertinoIcons.rectangle_grid_1x2_fill),
                            color: Colors.white,
                            iconSize: 15,
                            onPressed: () {
                              setSwitchList();
                            },
                          ),
                        ],
                      ),
                      stretchModes: [
                        StretchMode.zoomBackground,
                        StretchMode.fadeTitle
                      ],
                      background: Container(
                        margin: EdgeInsets.fromLTRB(3, 20, 3, 20),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xff23180d),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.brown),
                          image: DecorationImage(
                              scale: 1.3, image: AssetImage('assets/logo.png')),
                        ),
                      ),
                    ),
                  ),
                  SliverVisibility(
                      visible: !_switchList,
                      sliver: SliverGridWidget(list: d)),
                  SliverVisibility(
                      visible: _switchList,
                      sliver: SliverListWidget(list: d)),
                ],
              ),
            ),
        );
      }
    );
  }
}