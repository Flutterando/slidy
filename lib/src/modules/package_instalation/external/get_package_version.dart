import 'dart:convert';

import 'package:http/http.dart';
import 'package:slidy/src/modules/package_instalation/domain/errors/errors.dart';
import 'package:slidy/src/modules/package_instalation/infra/datasources/get_package_version.dart';

class GetPackageVersionImpl implements GetPackageVersion {
  final Client client;

  GetPackageVersionImpl(this.client);

  @override
  Future<String> fetch(String packageName) async {
    final url = 'https://pub.dev/api/packages/$packageName';
    try {
      var response = await client.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        var map = json['latest']['pubspec'];
        return map['version'];
      } else {
        throw PackageInstalationError('pub.dev request error');
      }
    } catch (e) {
      if (e is PackageInstalationError) {
        rethrow;
      } else {
        throw PackageInstalationError('Internet error');
      }
    }
  }
}
