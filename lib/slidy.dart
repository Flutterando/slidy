import 'dart:io';

import 'package:slidy/src/modules/package_instalation/main/package_instalation.dart';
import 'package:slidy/src/modules/template_creator/main/template_creator.dart';

import 'di/injection.dart';
import 'src/main_module.dart';

export 'src/modules/template_creator/domain/models/template_info.dart';
export 'src/core/entities/slidy_process.dart';
export 'src/core/errors/errors.dart';
export 'src/modules/package_instalation/domain/models/package_name.dart';

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

  final instalation = PackageInstalation();
  final template = TemplateCreator();

  Future<File> getParentModule(Directory dir) async {
    final files = await dir.list();

    await for (var file in files) {
      if (file.path.contains('_module.dart')) {
        return file as File;
      }
    }

    return await getParentModule(dir.parent);
  }
}
