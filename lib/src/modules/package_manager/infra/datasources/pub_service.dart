abstract class PubService {
  Future<List<String>> fetchVersions(String packageName);
  Future<List<String>> searchPackage(String packageName);
}
