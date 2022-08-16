import 'dart:io';

import 'package:slidy/src/modules/template_generator/main/template_creator.dart';

import 'di/injection.dart';
import 'src/main_module.dart';

export 'src/core/entities/slidy_process.dart';
export 'src/core/errors/errors.dart';
export 'src/core/prints/prints.dart';
export 'src/modules/package_manager/domain/params/package_name.dart';

class Slidy {
  static final Slidy instance = Slidy._internal();

  Slidy._();

  factory Slidy._internal() {
    StartAllModules();
    return Slidy._();
  }

  T get<T>() {
    return sl.get<T>();
  }

  final template = TemplateCreator();

  Future<File> getParentModule(Directory dir) async {
    await for (var file in dir.list()) {
      if (file.path.contains('_module.dart')) {
        return file as File;
      }
    }

    return await getParentModule(dir.parent);
  }
}
