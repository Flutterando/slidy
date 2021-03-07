import 'dart:io';

class TemplateInfo {
  final File destiny;
  final File yaml;
  final String key;
  late final List<String> args;

  TemplateInfo({required this.key, required this.destiny, required this.yaml, List<String>? args}) {
    this.args = args ?? [];
  }
}
