import 'package:path/path.dart';
import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart' as file_utils;

class Generate {
  static module(String path, bool createCompleteModule) async {
    String moduleType = createCompleteModule ? 'module_complete' : 'module';
    await file_utils.createFile(path, moduleType, templates.moduleGenerator);
    if (createCompleteModule) {
      await page(path, false);
    }
  }

  static page(String path, bool blocLess) {
    file_utils.createFile(path, 'page', templates.pageGenerator);
    String name = basename(path);
    if (!blocLess) {
      bloc("$path/$name");
    }
  }

  static widget(String path, bool blocLess, bool ignoreSufix) {
    if (ignoreSufix) {
      file_utils.createFile(
          path, 'widget', templates.widgetGeneratorWithoutSufix);
    } else {
      file_utils.createFile(path, 'widget', templates.widgetGenerator);
    }

    String name = basename(path);
    if (!blocLess) {
      bloc("$path/$name");
    }
  }

  static repository(String path) {
    file_utils.createFile(path, 'repository', templates.repositoryGenerator);
  }

  static bloc(String path) {
    file_utils.createFile(path, 'bloc', templates.blocGenerator);
  }
}
