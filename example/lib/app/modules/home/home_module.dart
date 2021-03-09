import 'external/datasource/get_user_list3_data_source.dart';
import 'external/datasource/get_user_list2_data_source.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => GetUserList3DataSourceImpl(i())),
    Bind.lazySingleton((i) => GetUserList2DataSourceImpl(i())),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
  ];
}
