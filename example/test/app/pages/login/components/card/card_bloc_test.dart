import 'package:flutter_test/flutter_test.dart';

import 'package:example/app/pages/login/components/card/card_bloc.dart';

void main() {
  CardBloc bloc;

  setUp(() {
    bloc = CardBloc();
  });

  group('CardBloc Test', () {
    test("First Test", () {
      expect(bloc, isInstanceOf<CardBloc>());
    });
  });
}
