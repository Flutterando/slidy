import 'package:fpdart/fpdart.dart';
import 'package:recase/recase.dart';
import 'package:slidy/src/core/services/yaml_service_impl.dart';
import 'package:slidy/src/modules/template_generator/domain/errors/errors.dart';
import 'package:yaml/yaml.dart';

import '../../../../core/entities/slidy_process.dart';
import '../../../../core/errors/errors.dart';
import '../models/template_info.dart';

abstract class Create {
  Future<Either<SlidyError, SlidyProccess>> call(TemplateInfo params);
}

class CreateImpl implements Create {
  @override
  Future<Either<SlidyError, SlidyProccess>> call(TemplateInfo params) async {
    final fileName = params.destiny.uri.pathSegments.last.replaceFirst('.dart', '');
    if (await params.destiny.exists()) {
      return Left(TemplateCreatorError('File $fileName exists'));
    }
    if (!await params.yaml.exists()) {
      return Left(TemplateCreatorError('YAML Not Exist'));
    }

    await params.destiny.create(recursive: true);

    final service = YamlServiceImpl(yaml: params.yaml);
    final node = service.getValue([params.key]);
    if (node is YamlScalar) {
      var list = node.value.toString().trim().split('/n');
      list = list.map<String>((e) => _processLine(e, params.args, fileName)).toList();
      await params.destiny.writeAsString(list.join('\n'));
      return Right(SlidyProccess(result: '$fileName created'));
    } else {
      return Left(TemplateCreatorError('Incorrect YAML'));
    }
  }

  String _processLine(String value, List<String> args, String fileName) {
    value = value.replaceAll('\$fileName|camelcase', ReCase(fileName).camelCase);
    value = value.replaceAll('\$fileName|pascalcase', ReCase(fileName).pascalCase);
    value = value.replaceAll('\$fileName', fileName);

    if (args.isEmpty) return value;
    for (var i = 0; i < args.length; i++) {
      final key = '\$arg${i + 1}';
      value = value.replaceAll(key, args[i]);
    }
    return value;
  }
}
