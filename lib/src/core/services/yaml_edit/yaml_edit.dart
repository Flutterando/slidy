// Copyright 2020 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     https://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/// YAML parsing is supported by `package:yaml`, and each time a change is
/// made, the resulting YAML AST is compared against our expected output
/// with deep equality to ensure that the output conforms to our expectations.
///
/// **Example**
/// ```dart
/// import 'package:yaml_edit/yaml_edit.dart';
///
/// void main() {
///  final yamlEditor = YamlEditor('{YAML: YAML}');
///  yamlEditor.update(['YAML'], "YAML Ain't Markup Language");
///  print(yamlEditor);
///  // Expected Output:
///  // {YAML: YAML Ain't Markup Language}
/// }
/// ```
///
/// [1]: https://yaml.org/

export 'src/editor.dart';
export 'src/source_edit.dart';
export 'src/wrap.dart' show wrapAsYamlNode;
