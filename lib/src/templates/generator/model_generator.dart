import 'package:recase/recase.dart';
import 'package:slidy/src/utils/object_generate.dart';

String modelGeneratorJsonSerializable(ObjectGenerate obj) => '''
import 'package:json_annotation/json_annotation.dart';

part '${ReCase(obj.name).snakeCase}_model.g.dart';

@JsonSerializable()
class ${obj.name}Model {

  String name;

  ${obj.name}Model({ this.name });

  factory ${obj.name}Model.fromJson(Map<String, dynamic> json) => _\$${obj.name}ModelFromJson(json);

  Map<String, dynamic> toJson() => _\$${obj.name}ModelToJson(this);
}
''';

String modelRxGeneratorJsonSerializable(ObjectGenerate obj) => '''
import 'package:mobx/mobx.dart';
import 'package:json_annotation/json_annotation.dart';

part '${ReCase(obj.name).snakeCase}_model.g.dart';

@JsonSerializable()
class ${obj.name}Model extends _${obj.name}ModelBase with _\$${obj.name}Model {
  ${obj.name}Model({String name}) : super(name: name);

  factory ${obj.name}Model.fromJson(Map<String, dynamic> json) => _\$${obj.name}ModelFromJson(json);

  Map<String, dynamic> toJson() => _\$${obj.name}ModelToJson(this);
}

abstract class _${obj.name}ModelBase with Store {
  @observable
  String name;

  _${obj.name}ModelBase({this.name});
}
  ''';

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
part '${ReCase(obj.name).snakeCase}_model.g.dart';

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
