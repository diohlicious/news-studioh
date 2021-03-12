import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_studioh/app/pages/webview/webview_bloc.dart';
import 'package:news_studioh/app/pages/webview/webview_page.dart';

class WebviewModule extends Module {

  @override
  final List<Bind> binds = [
        Bind((i) => WebviewBloc()),
      ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (_, args) => WebviewPage(article: args.data)),
      ];
}

