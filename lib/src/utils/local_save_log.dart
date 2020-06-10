import 'dart:io';

import 'package:path/path.dart';
import 'package:slidy/src/utils/output_utils.dart' as output;

class LocalSaveLog {
  String _path;
  int _key;

  static final LocalSaveLog _instance = LocalSaveLog._internal();

  factory LocalSaveLog() {
    return _instance;
  }

  LocalSaveLog._internal() {
    _path = '.slidy';
    _key = DateTime.now().millisecondsSinceEpoch;
  }

  void add(String value) {
    final file = File('$_path/$_key');
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    final body = file.readAsStringSync();
    file.writeAsStringSync('$body\n$value'.trim());
  }

  void removeLastLog() {
    try {
      final dir = Directory(_path);
      if (dir.existsSync()) {
        final listInt = dir
            .listSync()
            .map((e) => basename(e.path))
            .map((e) => int.parse(e))
            .toList();
        listInt.sort((a, b) => b.compareTo(a));
        final first = listInt.first;
        _removeFilesInLog('$first');
      }
    } catch (e) {
      print(e);
    }
  }

  void _removeFilesInLog(String key) {
    print(key);
    final file = File('$_path/$key');
    if (file.existsSync()) {
      for (final item in file.readAsStringSync().split('\n')) {
        final arch = File(item);
        if (arch.existsSync()) {
          arch.deleteSync(recursive: true);
          _removeEmptyFolder(arch.parent);
          output.warn('REMOVED: $item');
        }
      }
      file.deleteSync();
    }
  }

  void _removeEmptyFolder(Directory dir) {
    if (dir.listSync().isEmpty) {
      dir.deleteSync();
      _removeEmptyFolder(dir.parent);
    }
  }
}
