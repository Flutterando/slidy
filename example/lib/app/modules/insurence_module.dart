import 'package:flutter_modular/flutter_modular.dart';

import 'insurence/insurence_page.dart';
import 'insurence/insurence_store.dart';

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
