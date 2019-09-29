import 'package:http/http.dart' as http;
import 'dart:convert';

const URL_API = "https://pub.dartlang.org/api/packages";

class PubService {
  Future<String> getPackage(String pack, String version) async {
    String url = URL_API + "/$pack";

    if (version.isNotEmpty) {
      url += "/versions/$version";
    }

    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      var map = version.isEmpty ? json['latest']['pubspec'] : json['pubspec'];
      return map['version'];
    } else {
      throw Exception("error");
    }
  }
}
