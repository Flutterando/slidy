import 'package:example/app/bloc/test_bloc.dart';
import 'package:example/app/bloc/test_bloc.dart';
import 'package:example/app/teee_service.dart';
import 'package:example/app/teee_repository.dart';
import 'package:example/app/teee_store.dart';
import 'package:example/app/home/home_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => TestBloc()),
    Bind.lazySingleton((i) => TestBloc()),
    Bind.lazySingleton((i) => TeeeService()),
    Bind.lazySingleton((i) => TeeeRepository()),
    Bind.lazySingleton((i) => TeeeStore()),
    Bind.lazySingleton((i) => HomeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: HomeModule()),
  ];
}
