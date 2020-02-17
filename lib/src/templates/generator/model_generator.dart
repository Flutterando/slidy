import 'package:slidy/src/utils/object_generate.dart';

String modelGenerator(ObjectGenerate obj) => '''
class ${obj.name}Model {

  ${obj.name}Model();

  factory ${obj.name}Model.fromJson(Map<String, dynamic> json){
    return ${obj.name}Model(
      //field: json[''],
    );
  }

  Map<String,dynamic> toJson() => {};

}
  ''';

String modelRxGenerator(ObjectGenerate obj) => '''
import 'package:mobx/mobx.dart';
part '${obj.name.toLowerCase()}_model.g.dart';

class ${obj.name}Model extends _${obj.name}ModelBase with _\$${obj.name}Model {
  ${obj.name}Model({String name}) : super(name: name);

  factory ${obj.name}Model.fromJson(Map<String, dynamic> json) {
    return ${obj.name}Model(name: json['name']);
  }

  Map<String, dynamic> toJson() => {
        'name': this.name,
      };
}

abstract class _${obj.name}ModelBase with Store {
  @observable
  String name;

  _${obj.name}ModelBase({this.name});
}
  ''';
