import 'package:slidy/src/utils/output_utils.dart' as output;
import 'package:slidy/src/templates/templates.dart' as templates;
import 'package:slidy/src/utils/file_utils.dart' as file_utils;
import 'package:slidy/src/utils/utils.dart';

class Generate {

  Generate(args) {
    if (args[1] == 'module' || args[1] == 'm') {
      module(args[2]);
    } else if (args[1] == 'page' || args[1] == 'p') {
      page(args[2], checkParam(args, "-b"));
    } else if (args[1] == 'widget' || args[1] == 'w') {
      widget(args[2], checkParam(args, "-b"));
    } else if (args[1] == 'bloc' || args[1] == 'b') {
      bloc(args[2]);
    } else if (args[1] == 'repository' || args[1] == 'r') {
      repository(args[2]);
    } else {
      output.error("Generate: Invalid Command");
    }
  }

  module(String path) {
    file_utils.createFile(path, 'module', templates.moduleGenerator);
  }

  page(String path, bool blocLess) {
    file_utils.createFile(path, 'page', templates.pageGenerator);
    if (!blocLess) file_utils.createFile(path, 'bloc', templates.blocGenerator);
  }

  widget(String path, bool blocLess) {
    file_utils.createFile(path, 'widget', templates.widgetGenerator);
    if (!blocLess) file_utils.createFile(path, 'bloc', templates.blocGenerator);
  }

  repository(String path) {
    file_utils.createFile(path, 'repository', templates.repositoryGenerator);
  }

  bloc(String path) {
    file_utils.createFile(path, 'bloc', templates.blocGenerator);
  }
}
