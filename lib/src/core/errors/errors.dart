abstract class SlidyError implements Exception {
  final String message;

  SlidyError(this.message);

  @override
  String toString() {
    return '$runtimeType: message';
  }
}
