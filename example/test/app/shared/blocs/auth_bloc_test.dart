import 'package:flutter_test/flutter_test.dart';

import 'package:example/app/shared/blocs/auth_bloc.dart';

void main() {
  AuthBloc bloc;

  setUp(() {
    bloc = AuthBloc();
  });

  group('AuthBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<AuthBloc>());
    });
  });
}
