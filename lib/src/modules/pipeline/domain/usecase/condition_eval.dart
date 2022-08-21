abstract class ConditionEval {
  bool call(String? expression);
}

class ConditionEvalImpl implements ConditionEval {
  @override
  bool call(String? expression) {
    if (expression == null) {
      return true;
    }

    final splits = expression //
        .split(RegExp(' +'))
        .map((e) => e.trim())
        .toList();

    final args = <String>[];
    final results = <bool>[];

    final divides = <String>['&&'];

    for (var element in splits) {
      if (['||', '&&'].contains(element)) {
        divides.add(element);
        continue;
      }
      args.add(element);
      if (args.length == 3) {
        final result = _compare(args[0], args[1], args[2]);
        results.add(result);
        args.clear();
      }
    }

    if (results.length == 1) {
      return results.first;
    }
    var count = 0;

    return results.fold<bool>(true, (previousValue, element) {
      var divide = divides[count];
      count++;
      if (divide == '&&') {
        return previousValue && element;
      }

      return previousValue || element;
    });
  }

  bool _compare(String text1, String operator, String text2) {
    if (operator == '==') {
      return text1 == text2;
    } else if (operator == '!=') {
      return text1 != text2;
    } else {
      throw Exception('Operator "$operator" not exists.');
    }
  }
}
