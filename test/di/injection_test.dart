import 'package:slidy/di/injection.dart';
import 'package:test/test.dart';

void main() {
  tearDown(() {
    sl.cleanModule();
  });
  test('added injection', () {
    expect(() => sl.get<String>(), throwsA(isA<Exception>()));
    sl.register((i) => 'String');
    expect(sl.get<String>(), 'String');

    expect(() => sl.get<bool>(), throwsA(isA<Exception>()));
    sl.register((i) => true);
    expect(sl.get<bool>(), true);
  });

  test('duplicate injection', () {
    sl.register((i) => 'String');
    expect(() => sl.register((i) => 'String'), throwsA(isA<Exception>()));
  });

  test('constructor inject', () {
    sl.register((i) => Person(i()));
    sl.changeRegister((i) => 'Jacob');
    expect(sl.get<Person>().name, 'Jacob');
  });
}

class Person {
  final String name;

  Person(this.name);
}
