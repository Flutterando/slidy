import 'package:slidy/src/modules/pipeline/domain/usecase/condition_eval.dart';
import 'package:test/test.dart';

void main() {
  test('condition unique', () {
    // arrage
    final usecase = ConditionEvalImpl();

    // act
    final result = usecase.call('test == test');

    // assert
    expect(result, true);
  });

  test('condition unique error', () {
    final usecase = ConditionEvalImpl();
    final result = usecase.call('test != test');
    expect(result, false);
  });

  test('condition &&', () {
    final usecase = ConditionEvalImpl();
    final result = usecase.call('test == test && test2 != test1');
    expect(result, true);
  });

  test('condition ||', () {
    final usecase = ConditionEvalImpl();
    final result = usecase.call('test == test || test2 == test1');
    expect(result, true);
  });

  test('condition ||', () {
    final usecase = ConditionEvalImpl();
    final result = usecase.call('test == test || test2 == test1');
    expect(result, true);
  });
}
