import 'package:dio/dio.dart';  
import '../../infra/datasource/get_user_list2_data_source.dart';
class GetUserList2DataSourceImpl implements IGetUserList2DataSource {
  final Dio dio;

  GetUserList2DataSourceImpl(this.dio);

  @override
  Future<List<String>> getListData() async {
    var response = await dio.get('url');
    return response.data;
  }
}