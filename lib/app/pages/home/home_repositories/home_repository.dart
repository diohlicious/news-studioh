import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_studioh/app/network/network_const.dart';
import 'package:news_studioh/app/network/network_endpoints.dart';
import 'package:news_studioh/app/pages/home/home_model/news_model.dart';
import 'package:news_studioh/app/utils/network_util.dart';

class HomeRepository extends Disposable {
  Future<List<Article>> fetchNews(String search, int i) => NetworkUtil()
          .get(
              url: Uri.https(NetworkEndpoints.BASE_URL, '/v2/everything', {
        'apiKey': apiKey,
        'q': search??'indonesia',
        'pageSize': '100',
        'page': i == null ? '1' : '$i',
        'sortBy': 'publishedAt'
      }))
          .then((dynamic response) {
        final _newsModel = NewsModel.fromJson(response);
        return _newsModel.articles;
      });

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
