import 'dart:convert';
import 'dart:io';
import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/modules/template_creator/domain/models/template_info.dart';
import 'package:slidy/src/modules/template_creator/domain/usecases/create.dart';
import 'package:test/test.dart';

class FileYamlMock extends Mock implements File {
  String savedFile = '';

  @override
  Future<bool> exists() async {
    return true;
  }

  @override
  Future<File> writeAsString(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) async {
    savedFile = contents;
    return this;
  }

  @override
  void writeAsStringSync(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) {
    savedFile = contents;
  }
}

class FileDestinyMock extends Mock implements File {
  String savedFile = '';

  @override
  Uri get uri => Uri.parse('lib/main.dart');

  @override
  Future<File> create({bool recursive = false}) async {
    return this;
  }

  @override
  Future<bool> exists() async {
    return false;
  }

  @override
  Future<File> writeAsString(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) async {
    savedFile = contents;
    return this;
  }

  @override
  void writeAsStringSync(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) {
    savedFile = contents;
  }
}

void main() {
  final yaml = FileYamlMock();
  final destiny = FileDestinyMock();

  final usecase = Create();

  test('should create template', () async {
    when(() => yaml.readAsStringSync()).thenReturn(yamlText);
    final result = await usecase(params: TemplateInfo(yaml: yaml, destiny: destiny, key: 'main'));
    expect(result.right, isA<SlidyProccess>());
    expect(destiny.savedFile, savedText);
  });
  test('should create template with args', () async {
    when(() => yaml.readAsStringSync()).thenReturn(yamlText);
    final result = await usecase(params: TemplateInfo(yaml: yaml, destiny: destiny, key: 'main', args: ['Modular()']));
    expect(result.right, isA<SlidyProccess>());
    expect(destiny.savedFile, savedTextWithArgs);
  });

  test('should create template with real yaml', () async {
    // final result = await usecase(params: TemplateInfo(yaml: File('lib/'), destiny: destiny, key: 'main', args: ['Modular()']));
    // expect(result.right, isA<SlidyProccess>());
    // expect(destiny.savedFile, savedTextWithArgs);
  });
}

const yamlText = '''
main: |
  void main() {
    runApp(myApp(\$arg1));
  }
''';
final savedText = '''
void main() {
  runApp(myApp(\$arg1));
}'''
    .trim();

final savedTextWithArgs = '''
void main() {
  runApp(myApp(Modular()));
}'''
    .trim();
