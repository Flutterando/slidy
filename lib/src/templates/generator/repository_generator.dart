String repositoryGenerator(String name) => '''
import 'package:bloc_pattern/bloc_pattern.dart';
<<<<<<< HEAD

class ${name}Repository extends Disposable {

  //dispose will be called automatically by closing its streams
=======
import 'package:dio/dio.dart';

class ${name}Repository extends Disposable {


  Future fetchPost(Dio client) async {
    final response =
        await client.get('https://jsonplaceholder.typicode.com/posts/1');
    return response.data;
  }


  //dispose will be called automatically
>>>>>>> 2f431f953aed90d425f32232a3317fd7f82f3bb4
  @override
  void dispose() {
    
  }

}
  ''';
