import 'package:slidy/src/modules/run/infra/services/yaml_reader_service.dart';
import 'package:test/test.dart';

void main() {
  test('yaml reader service ...', () {
    final service = YamlReaderServiceImpl();

    final result = service.readYaml(r'''
name: Slidy Pipeline
version: 1

variables:
  var1: myVariable   # Get  ${Local.var1}
  var2: ${System.FLUTTER_HOME}  # Gets env variables

scripts:
  doctor: flutter doctor
  clean:
    name: Clean
    description: my great desc.
    command: flutter clean
  clean-get:
    description: my great desc.
    steps:
      - name: Clean
        run: flutter clean
      - name: Get
        run: flutter pub get

''');
    print(result);
  });
}
