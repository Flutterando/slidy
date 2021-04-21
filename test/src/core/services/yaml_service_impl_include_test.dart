import 'dart:convert';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/interfaces/yaml_service.dart';
import 'package:slidy/src/core/services/yaml_service_impl.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

class FileMock extends Mock implements File {
  String savedFile = '';

  final String stringYaml;

  FileMock(this.stringYaml);

  @override
  Future<File> writeAsString(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) async {
    savedFile = contents;
    return this;
  }

  @override
  Future<String> readAsString({Encoding encoding = utf8}) async {
    return stringYaml;
  }

  @override
  String readAsStringSync({Encoding encoding = utf8}) {
    return stringYaml;
  }
}

void main() {
  test('include one', () async {
    final file = FileMock(stringYaml);
    final service = await YamlServiceImpl(
        yaml: file,
        getYamlFileParam: (file, path) {
          return FileMock(otherYaml);
        }).readAllIncludes();

    final node = service.getValue(['name']);
    expect(node?.value, 'slidy');
  });
}

const stringYaml = ''' 
include: folder/other.yaml
''';

const otherYaml = ''' 
name: slidy
''';
