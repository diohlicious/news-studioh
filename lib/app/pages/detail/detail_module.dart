import 'package:flutter_modular/flutter_modular.dart';

import 'detail_bloc.dart';
import 'detail_page.dart';

class DetailModule extends Module{

  @override
  List<Bind> get binds => [
    Bind.factory((i) => DetailBloc()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => DetailPage(article: args.data,)),
  ];

}