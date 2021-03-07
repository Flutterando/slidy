import 'dart:collection';

class Pubspec {
  final List<Line> lines;

  Pubspec(this.lines);
}

class Line {
  final String name;
  final dynamic value;

  Line({required this.name, required this.value});

  Line copyWith({
    String? name,
    dynamic? value,
  }) {
    return Line(
      name: name ?? this.name,
      value: value ?? this.value,
    );
  }

  factory Line.package({required String name, required String version, bool isDev = false}) {
    return Line(name: isDev ? 'dev_dependencies' : 'dependencies', value: LineMap({name: Line(name: name, value: version)}));
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Line && o.name == name && o.value.runtimeType == value.runtimeType;
  }

  @override
  int get hashCode => name.hashCode;
}

class NoCountLine extends Line {
  NoCountLine(String content, int index) : super(name: content, value: index);
}

class LineMap with MapMixin<String, Line> implements Map<String, Line> {
  late final Map<String, Line> _map;

  LineMap([Map<String, Line>? map]) {
    _map = map ?? {};
  }

  @override
  Line? operator [](Object? key) {
    return _map[key];
  }

  @override
  void operator []=(String key, Line value) {
    _map[key] = value;
  }

  @override
  void clear() {
    _map.clear();
  }

  @override
  Iterable<String> get keys => _map.keys;

  @override
  Line? remove(Object? key) {
    _map.remove(key);
  }
}

class LineList with ListMixin<Line> {
  late final List<Line> _list;

  LineList([List<Line>? list]) {
    _list = list ?? [];
  }

  @override
  set length(int newLength) => _list.length = newLength;

  @override
  int get length => _list.length;

  @override
  void add(Line element) {
    _list.add(element);
  }

  @override
  Line operator [](int index) {
    return _list[index];
  }

  @override
  void operator []=(int index, Line value) {
    _list[index] = value;
  }
}
