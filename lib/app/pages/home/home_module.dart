import 'package:flutter_modular/flutter_modular.dart';
import 'package:news_studioh/app/pages/home/home_repositories/home_repository.dart';

import 'home_bloc.dart';
import 'home_page.dart';

class HomeModule extends Module{


  @override
  final List<Bind> binds = [
    Bind.factory((i) => HomeBloc(i.get())),
    Bind.factory((i) => HomeRepository()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => HomePage()),
  ];

}