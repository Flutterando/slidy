String modelGenerator(String name) => '''
class ${name}Model {

  ${name}Model();

  factory ${name}Model.fromJson(Map<String, dynamic> json){
    return ${name}Model(
      //field: json[''],
    );
  }

  Map<String,dynamic> toJson(${name}Model  model){
    Map<String,dynamic> json = Map<String,dynamic>();

    return json;
  }

}
  ''';
