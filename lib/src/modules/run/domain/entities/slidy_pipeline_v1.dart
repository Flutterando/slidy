/*
name: Slidy Pipeline
version: 1

variables:
  var1: myVariable   # Get  ${Local.var1}
  var2: ${System.FLUTTER_HOME}  # Gets env variables

scripts:
 <file script.dart>

*/

import 'script.dart';

class SlidyPipelineV1 {
  final String version;
  final Map<String, String> localVariables;
  final Map<String, String> systemVariables;
  final Map<String, Script> scripts;

  SlidyPipelineV1({
    this.version = '1',
    this.localVariables = const {},
    this.systemVariables = const {},
    this.scripts = const {},
  });

  SlidyPipelineV1 copyWith({
    String? version,
    String? name,
    Map<String, String>? localVariables,
    Map<String, String>? systemVariables,
    Map<String, Script>? scripts,
  }) {
    return SlidyPipelineV1(
      version: version ?? this.version,
      localVariables: localVariables ?? this.localVariables,
      systemVariables: systemVariables ?? this.systemVariables,
      scripts: scripts ?? this.scripts,
    );
  }
}
