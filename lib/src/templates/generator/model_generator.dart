String modelGenerator(String name) => '''
class ${name}Model {

  ${name}Model();

  factory ${name}Model.fromJson(Map<String, dynamic> json){
    return ${name}Model(
      //field: json[''],
    );
  }

  Map<String,dynamic> toJson() => {};

}
  ''';

String modelRxGenerator(String name) => '''
import 'package:mobx/mobx.dart';
part '${name.toLowerCase()}_model.g.dart';

class ${name}Model extends _${name}ModelBase with _\$${name}Model {
  ${name}Model({String name}) : super(name: name);

  factory ${name}Model.fromJson(Map<String, dynamic> json) {
    return ${name}Model(name: json['name']);
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
      };
}

abstract class _${name}ModelBase with Store {
  @observable
  String name;

  _${name}ModelBase({this.name});
}
  ''';
