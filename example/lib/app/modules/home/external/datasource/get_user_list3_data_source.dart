import 'package:dio/dio.dart';  
import '../../infra/datasource/get_user_list3_data_source.dart';
class GetUserList3DataSourceImpl implements IGetUserList3DataSource {
  final Dio dio;

  GetUserList3DataSourceImpl(this.dio);

  @override
  Future<List<String>> getListData() async {
    var response = await dio.get('url');
    return response.data;
  }
}