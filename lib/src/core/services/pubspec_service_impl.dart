import 'dart:io';

import '../interfaces/pubspec_service.dart';
import '../models/pubspec.dart';

class PubspecServiceImpl implements PubspecService {
  final File yaml;

  PubspecServiceImpl({required this.yaml});

  @override
  Future<List<Line>> loadYaml() async {
    final strings = await yaml.readAsLines();

    final lines = <Line>[];

    for (var j = 0; j < strings.length; j++) {
      var string = strings[j];
      if (string.startsWith(RegExp(r' *#'))) {
        final line = NoCountLine(string, j);
        lines.add(line);
        continue;
      } else if (string.startsWith(RegExp(r'[a-z]'))) {
        final elements = string.split(':');
        final line = Line(name: elements[0].trim(), value: elements[1].trim().isEmpty ? null : elements[1].trim());
        lines.add(line);
        continue;
      } else if (string.startsWith(RegExp(r'  +[a-z]'))) {
        final elements = string.split(':');
        var internal = string.replaceAll('  ', '//44//').split('//44//').length - 1;

        final line = Line(name: elements[0].trim(), value: elements[1].trim().isEmpty ? null : elements[1].trim());
        dynamic candidate = lines.where((element) => element is! NoCountLine).last;
        final tempLines = <dynamic>[];
        for (var i = 0; i < internal; i++) {
          tempLines.add(candidate);
          if (tempLines.last is LineMap) {
            final key = (tempLines.last as LineMap).keys.last;
            if (tempLines.last[key].value == null) {
              tempLines.last[key] = tempLines.last[key].copyWith(value: LineMap({line.name: line}));
            } else {
              tempLines.last[key].value[line.name] = line;
            }
          } else if (tempLines.last.value is Line) {
            candidate = tempLines.last.value;
          } else if (tempLines.last.value == null) {
            tempLines.last = tempLines.last.copyWith(value: LineMap({line.name: line}));
          } else if (tempLines.last.value is LineMap && i == (internal - 1)) {
            tempLines.last.value[line.name] = line;
          } else if (tempLines.last.value is LineMap) {
            candidate = (tempLines.last.value as LineMap);
          }
        }

        lines.last = tempLines.reversed.reduce((value, element) => element.copyWith(value: value));
        continue;
      } else if (string.startsWith(RegExp(r'  +-'))) {
        var internal = string.split('-')[0].replaceAll('  ', '//44//').split('//44//').length - 1;
        final line = Line(name: 'array', value: string.replaceFirst(RegExp(r' +- '), ''));
        var candidate = lines.last;
        final tempLines = <Line>[];

        for (var i = 0; i < internal; i++) {
          tempLines.add(candidate);
          if (candidate.value is Line) {
            candidate = candidate.value;
          } else if (tempLines.last.value == null) {
            tempLines.last = tempLines.last.copyWith(value: LineList([line]));
          } else if (tempLines.last.value is LineList) {
            tempLines.last.value.add(line);
          }
        }
        lines.last = tempLines.length == 1
            ? tempLines.first
            : tempLines.reversed.reduce((value, element) {
                return element.copyWith(value: value);
              });
        continue;
      } else {
        final line = NoCountLine(string, j);
        lines.add(line);
      }
    }

    if (lines.last.name == '') lines.removeLast();
    return lines;
  }

  @override
  Future<bool> add(Line line) async {
    final lines = await loadYaml();
    Line? candidate;
    var index = 0;
    for (var item in lines) {
      if (item.name == line.name) {
        candidate = item;
        break;
      }
      index++;
    }

    if (candidate == null) {
      lines.add(line);
    } else {
      var adding = line;
      final tempLines = <Line>[];
      while (candidate != null) {
        if (candidate.value is String) {
          tempLines.add(line);
          candidate = null;
        } else if (candidate.value is LineMap && adding.value is LineMap) {
          (candidate.value as LineMap).addAll(adding.value);
          tempLines.add(candidate);
          candidate = null;
        } else if (candidate.value is LineList && adding.value is LineList) {
          (candidate.value as LineList).addAll(adding.value);
          tempLines.add(candidate);
          candidate = null;
        } else if (candidate.value.value is Line && adding.value.value is Line && (candidate.value.name != adding.value.name)) {
          tempLines.add(candidate);
          candidate = null;
        } else if (candidate.value.value is Line && adding.value.value is Line && (candidate.value.name == adding.value.name)) {
          candidate = candidate.value;
          adding = adding.value;
        } else {
          candidate = null;
        }
      }
      if (tempLines.isEmpty) {
        return false;
      } else {
        lines[index] = tempLines.reversed.reduce((value, element) => element.copyWith(value: value));
      }
    }

    return save(lines);
  }

  Future<bool> save(List<Line> lines) async {
    var pub = <String>[];
    for (var line in lines.where((element) => element is! NoCountLine).toSet()) {
      final list = _prepareLines(line);
      pub.addAll(list);
    }
    try {
      await yaml.writeAsString(pub.join('\n'));
      return true;
    } catch (e) {
      return false;
    }
  }

  String _space(int internal) {
    if (internal == 0) {
      return '';
    } else if (internal == 1) {
      return '  ';
    }

    return List.generate(internal, (index) => '  ').join();
  }

  List<String> _prepareLines(Line line, {int internal = 0}) {
    var pub = <String>[];
    Line? candidate = line;

    while (candidate != null) {
      if (line.value is String) {
        pub.add('${_space(internal)}${line.name}: ${line.value}');
        candidate = null;
      } else if (line.value is LineList) {
        pub.add('${_space(internal)}${line.name}:');
        internal++;
        pub.addAll(line.value.map<String>((e) => '${_space(internal)}- ${e.value}'));
        candidate = null;
      } else if (line.value is LineMap) {
        pub.add('${_space(internal)}${line.name}:');
        for (var key in (line.value as LineMap).keys) {
          pub.addAll(_prepareLines(line.value[key], internal: internal + 1));
        }
        candidate = null;
      } else if (line.value is Line) {
        pub.add('${_space(internal)}${line.name}:');
        candidate = line.value;
        internal++;
      } else {
        candidate = null;
      }
    }
    return pub;
  }

  @override
  Future<Line> getLine(String name) async {
    final lines = await loadYaml();
    return lines.firstWhere((element) => element.name == name);
  }

  @override
  Future<bool> replace(Line line) async {
    final lines = await loadYaml();
    Line? candidate;
    var index = 0;
    for (var item in lines) {
      if (item.name == line.name) {
        candidate = item;
        break;
      }
      index++;
    }

    if (candidate != null) {
      lines[index] = line;
      return await save(lines);
    } else {
      return false;
    }
  }
}
