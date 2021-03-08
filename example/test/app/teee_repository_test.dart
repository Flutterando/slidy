import 'package:flutter_test/flutter_test.dart';
import 'package:example/app/teee_repository.dart';
 
void main() {
  late TeeeRepository repository;

  setUpAll(() {
    repository = TeeeRepository();
  });
}