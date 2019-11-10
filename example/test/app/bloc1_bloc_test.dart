import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_pattern/bloc_pattern_test.dart';

import 'package:example/app/bloc1_bloc.dart';
import 'package:example/app/app_module.dart';

void main() {
  initModule(AppModule());
  Bloc1Bloc bloc;

  setUp(() {
    bloc = AppModule.to.bloc<Bloc1Bloc>();
  });

  group('Bloc1Bloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<Bloc1Bloc>());
    });
  });
}
