import 'dart:io';

class LineParams {
  final File file;
  final int position;
  final List<String> inserts;
  final String Function(String line)? replaceLine;

  LineParams(this.file,
      {this.position = 0, this.replaceLine, this.inserts = const []});
}
