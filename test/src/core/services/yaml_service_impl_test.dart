import 'dart:convert';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/services/yaml_service_impl.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart';

class FileMock extends Mock implements File {
  String savedFile = '';

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
  test('update', () async {
    final file = FileMock();
    final service = YamlServiceImpl(yaml: file);
    service.update(['dependencies', 'dart_console'], '2.0.0');
    await service.save();
    expect(loadYaml(file.savedFile)['dependencies']['dart_console'], '2.0.0');
  });
  test('remove', () async {
    final file = FileMock();
    final service = YamlServiceImpl(yaml: file);
    service.remove(['dependencies', 'dart_console']);
    await service.save();
    expect((loadYaml(file.savedFile)['dependencies'] as Map).containsKey('dart_console'), false);
  });
  test('getValue', () async {
    final file = FileMock();
    final service = YamlServiceImpl(yaml: file);
    final node = service.getValue(['dependencies', 'dart_console']);
    expect(node?.value, '^1.0.0');
  });
}

const stringYaml = ''' 
name: slidy
description: CLI package manager and template for Flutter. Generate Modules, Pages, Widgets, BLoCs, MobX, Triple and more.
version: 3.0.2
homepage: https://github.com/Flutterando/slidy

environment:
  sdk: '>=2.12.0 <3.0.0'

dependencies:
  dart_console: ^1.0.0
  either_dart: ^0.1.0-nullsafety.1
  http: ^0.13.0
  args: ^2.0.0
  ansicolor: ^2.0.0-nullsafety.0
  recase: ^4.0.0-nullsafety.0
  file: ^6.1.0
  yaml: ^3.1.0
  collection: ^1.14.11
  meta: ^1.1.8
  source_span: ^1.7.0

dev_dependencies:
  test: ^1.16.0-nullsafety.17
  mocktail: ^0.1.1

# dependency_overrides:
#   args: '2.0.0-nullsafety.0'


executables:
  slidy: slidy


''';
