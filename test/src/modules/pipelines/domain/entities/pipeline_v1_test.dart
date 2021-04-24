import 'package:either_dart/either.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline_v1.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() {
  test('fromJson', () {
    final yaml = loadYaml(yamlText);
    final pipeline = PipelineV1.fromMap(yaml as Map, (pipeline) => Right(SlidyProccess(result: 'result')));
    expect(pipeline.name, 'Slidy Pipeline');
    expect(pipeline.version, 'v1');
    expect(pipeline.jobs.first.name, 'Named Command');
    expect(pipeline.jobs.first.steps.first.id, 'First File Creation');
    expect(pipeline.jobs.first.steps.first.generate?.moduleInjection?.type, ModuleInjectionV1Type.bind);
  });
}

const yamlText = r''' 
name: Slidy Pipeline
version: v1

create_custom_file:  #this is command name
  name: Named Command
  steps:
  - id: First File Creation
    generate: 
      path: lib/app/path/file.dart
      file: |
        Generate file line 1
        generate file line 2 ${{ fileName | camelcase }}
      module_injection:
        type: bind
        value: Bind.singleton((i) => ${{ fileName | camelcase }}())
      run: echo "Custom Command"
    commands:
    - flutter pub get
    - flutter pub run build_runner build --delete-conflicting-outputs
''';
