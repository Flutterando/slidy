import 'package:slidy/src/core/models/pubspec.dart';

import 'pubspec_service.dart';

abstract class YamlService extends PubspecService {
  Future<List<Line>> getLines();
}
