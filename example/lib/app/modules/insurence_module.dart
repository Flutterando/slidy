import 'package:example/app/modules/insurence/insurence_Page.dart';
import 'package:example/app/modules/insurence/insurence_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InsurenceModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => InsurenceStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => InsurencePage()),
  ];
}
