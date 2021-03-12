import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import 'home_model/news_model.dart';
import 'home_repositories/home_repository.dart';

class HomeBloc extends Disposable{
  final HomeRepository homeRepository;
  HomeBloc(this.homeRepository);


  BehaviorSubject<List<Article>> article$ = BehaviorSubject<List<Article>>();


  String _txtSearch;

  String get txtSearch => _txtSearch;

  setTxtSearch(String val){
    _txtSearch=val;
  }

  Future fetchNews() async{
    int i;
    await homeRepository.fetchNews(txtSearch,i).then((value) => article$.add(value));
  }

  @override
  void dispose() {
    article$.close();
  }
}