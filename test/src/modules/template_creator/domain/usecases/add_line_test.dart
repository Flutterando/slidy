import 'dart:convert';
import 'dart:io';
import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/modules/template_creator/domain/models/line_params.dart';
import 'package:slidy/src/modules/template_creator/domain/usecases/add_line.dart';
import 'package:test/test.dart';

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
    return true;
  }

  @override
  Future<File> writeAsString(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) async {
    savedFile = contents;
    return this;
  }
}

void main() {
  final destiny = FileDestinyMock();

  final usecase = AddLine();

  test('should add one line in template', () async {
    when(() => destiny.readAsLines()).thenAnswer((_) async => yamlText.split('\n'));
    final result = await usecase(params: LineParams(destiny, inserts: ['jacob']));
    expect(result.right, isA<SlidyProccess>());
    expect(destiny.savedFile, savedText);
  });

  test('should add more then one line in template', () async {
    when(() => destiny.readAsLines()).thenAnswer((_) async => yamlText.split('\n'));
    final result = await usecase(params: LineParams(destiny, inserts: ['jacob', 'joão', 'maria']));
    expect(result.right, isA<SlidyProccess>());
    expect(destiny.savedFile, savedMultipleTexts);
  });

  test('should add line inside main()', () async {
    when(() => destiny.readAsLines()).thenAnswer((_) async => yamlText.split('\n'));
    final result = await usecase(params: LineParams(destiny, position: 1, inserts: ['inside();']));
    expect(result.right, isA<SlidyProccess>());
    expect(destiny.savedFile, savedTextInsertedInExpecificPosition);
  });

  test('should replace line', () async {
    when(() => destiny.readAsLines()).thenAnswer((_) async => yamlText.split('\n'));
    final result = await usecase(
        params: LineParams(
      destiny,
      replaceLine: (line) {
        if (line.contains('runApp(myApp());')) {
          return line.replaceFirst('runApp(myApp());', 'runApp(myApp(), addedNew());');
        }
        return line;
      },
    ));
    expect(result.right, isA<SlidyProccess>());
    expect(destiny.savedFile, savedTextAfterReplaced);
  });
  test('should added above line', () async {
    when(() => destiny.readAsLines()).thenAnswer((_) async => yamlText.split('\n'));
    final result = await usecase(
        params: LineParams(
      destiny,
      replaceLine: (line) {
        if (line.contains('void main(')) {
          return 'import \'test\';\n\n$line';
        }
        return line;
      },
    ));
    expect(result.right, isA<SlidyProccess>());
    expect(destiny.savedFile, savedTextAboveLine);
  });
}

const yamlText = '''
void main() {
   runApp(myApp());
}''';

const savedText = '''
jacob
void main() {
   runApp(myApp());
}''';

const savedMultipleTexts = '''
jacob
joão
maria
void main() {
   runApp(myApp());
}''';

const savedTextInsertedInExpecificPosition = '''
void main() {
inside();
   runApp(myApp());
}''';

const savedTextAfterReplaced = '''
void main() {
   runApp(myApp(), addedNew());
}''';
const savedTextAboveLine = '''
import 'test';

void main() {
   runApp(myApp());
}''';
