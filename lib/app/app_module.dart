import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_studioh/app/pages/detail/detail_module.dart';
import 'package:news_studioh/app/pages/home/home_module.dart';
import 'package:news_studioh/app/pages/webview/webview_module.dart';
import 'app_bloc.dart';
import 'app_widget.dart';

class AppModule extends Module {
  // Provide a list of dependencies to inject into your project
  @override
  final List<Bind> binds = [
    Bind((i) => AppBloc()),

  ];

  // Provide all the routes for your module
  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/',  module: HomeModule()),
    ModuleRoute('/detail',  module: DetailModule()),
    ModuleRoute('/webview',  module: WebviewModule()),
  ];

  Widget get bootstrap => AppWidget();
}