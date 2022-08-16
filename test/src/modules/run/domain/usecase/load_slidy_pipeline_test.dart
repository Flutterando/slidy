import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/modules/pipeline/domain/services/yaml_reader_service.dart';
import 'package:slidy/src/modules/pipeline/domain/usecase/load_slidy_pipeline.dart';
import 'package:test/test.dart';

class YamlReaderServiceMock extends Mock implements YamlReaderService {}

class FileMock extends Mock implements File {}

void main() {
  final yamlReader = YamlReaderServiceMock();

  final usecase = LoadSlidyPipelineImpl(yamlReader);

  test('load slidy pipeline', () async {
    final file = FileMock();
    when(() => file.readAsString()).thenAnswer((_) async => '');
    when(() => file.exists()).thenAnswer((_) async => true);
    when(() => yamlReader.readYaml('')).thenReturn(yamlMapResponse);

    final result = await usecase.call(file).run();
    expect(result.isRight(), true);
  });
}

/*
name: Slidy Pipeline
version: 1

variables:
  var1: myVariable   # Get  ${Local.var1}
  var2: ${System.FLUTTER_HOME}  # Gets env variables

scripts:
  doctor: flutter doctor
  clean:
    name: Clean
    description: my great desc.
    command: flutter clean
  clean-get:
    description: my great desc.
    steps:
      - name: Clean
        run: flutter clean
      - name: Get
        run: flutter pub get

*/

final yamlMapResponse = <String, dynamic>{
  'name': 'Slidy Pipeline',
  'version': '1',
  'variables': {'var1': 'myVariable', 'var2': r'${System.FLUTTER_HOME}'},
  'scripts': {
    'doctor': 'flutter doctor',
    'clean': {
      'name': 'Clean',
      'description': 'My description',
      'command': 'flutter clean',
    },
    'clean-get': {
      'description': 'My description',
      'steps': [
        {
          'name': 'Clean Project',
          'run': 'flutter clean',
        },
        {
          'name': 'Get packages',
          'run': 'flutter pub get',
        },
      ],
    },
  }
};
