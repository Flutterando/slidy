import 'package:modular_core/modular_core.dart';

import 'module.dart';

class Modular {
  Modular._();

  static void init(Module module) {
    modularTracker.runApp(module);
  }

  static B get<B extends Object>() {
    return modularTracker.injector.get<B>();
  }

  static void dispose() => modularTracker.finishApp();
}
