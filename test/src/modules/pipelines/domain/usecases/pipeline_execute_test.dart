import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:slidy/slidy.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline.dart';
import 'package:slidy/src/modules/pipelines/domain/entities/pipeline_v1.dart';
import 'package:slidy/src/modules/pipelines/domain/services/yaml_to_map_service.dart';
import 'package:slidy/src/modules/pipelines/domain/usecases/pipeline_execute.dart';
import 'package:slidy/src/modules/pipelines/domain/usecases/pipeline_v1_usecase.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

class YamlToMapServiceMock extends Mock implements YamlToMapService {}

class PipelineV1UsecaseMock extends Mock implements PipelineV1Usecase {}

void main() async {
  final yamlToMapService = YamlToMapServiceMock();
  final pipelineV1Usecase = PipelineV1UsecaseMock();
  setUpAll(() {
    registerFallbackValue<Pipeline>(PipelineV1.fromMap(loadYaml(yamlText), (pipeline, command, args) => pipelineV1Usecase.call(pipeline, command, args)));
  });
  final usecase = PipelineExecuteImpl(v1: pipelineV1Usecase, yamlToMapService: yamlToMapService);
  test('should execute pipeline v1', () async {
    when(() => yamlToMapService.convert(any())).thenAnswer((_) async => Right(loadYaml(yamlText)));
    when(() => pipelineV1Usecase.call(any(), any(), any())).thenAnswer((_) async => Right(SlidyProccess(result: 'ok ok!')));

    final result = await usecase.call(params: PipelineParams(yamlPath: '/path/yaml', command: 'command'));
    expect(result.isRight(), true);
    final pipelineResult = result.fold(id, id);
    expect(pipelineResult, isA<SlidyProccess>());
    expect((pipelineResult as SlidyProccess).result, 'ok ok!');
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
