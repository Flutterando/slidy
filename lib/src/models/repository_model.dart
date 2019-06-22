class RepositoryModel {
  String model(String name) => '''
import 'package:bloc_pattern/bloc_pattern.dart';

class ${name}Repository extends Disposable {

  //dispose will be called automatically by closing its streams
  @override
  void dispose() {
    
  }

}
  ''';
}