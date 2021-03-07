import '../models/pubspec.dart';

abstract class PubspecService {
  Future<bool> add(Line line);
  Future<bool> replace(Line line);
  Future<Line> getLine(String name);
  Future<List<Line>> loadYaml();
}
