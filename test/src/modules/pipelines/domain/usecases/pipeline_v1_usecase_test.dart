import 'package:dartz/dartz.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline_v1.dart';
import 'package:slidy/src/modules/pipelines/domain/usecases/pipeline_v1_usecase.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

void main() async {
  final usecase = PipelineV1UsecaseImpl();
  final pipeline = PipelineV1.fromMap(loadYaml(yamlText), usecase);
  test('should execute pipeline v1', () async {
    final result = await pipeline.call('print_text', []);
    expect(result.isRight(), true);
    final pipelineResult = result.fold(id, id);
    expect(pipelineResult, isA<SlidyProccess>());
    expect((pipelineResult as SlidyProccess).result, 'Slidy Pipeline');
  });
}

const yamlText = r''' 
name: Slidy Pipeline
version: v1

print_text:
  name: Name Print
  steps:
  - id: Print 1
    commands:
    - echo teste 1;
  - id: Print 2
    commands:
    - echo teste 2;

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
