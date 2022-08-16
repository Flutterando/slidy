import 'dart:io';

import 'package:pub_api_client/pub_api_client.dart';
import 'package:slidy/src/modules/package_manager/domain/errors/errors.dart';
import 'package:slidy/src/modules/package_manager/infra/datasources/pub_service.dart';

class PubServiceImpl implements PubService {
  final PubClient client;

  PubServiceImpl(this.client);

  @override
  Future<List<String>> fetchVersions(String packageName) async {
    try {
      final package = await client.packageInfo(packageName);
      return package.versions.map((e) => e.version).toList();
    } on NotFoundException {
      throw PackageManagerError('Package \'$packageName\' not found');
    } on SocketException catch (e) {
      if (e.osError?.errorCode == 11001) {
        throw PackageManagerError('Internet error');
      }
      rethrow;
    }
  }
}
