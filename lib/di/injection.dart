final Map<Type, dynamic Function(_Injection i)> _dependencies = {};

class _Injection {
  void register<T>(T Function(_Injection i) bind) {
    if (_dependencies.containsKey(T)) {
      throw Exception('bind alread registed');
    }
    _dependencies[T] = bind;
  }

  void changeRegister<T>(T Function(_Injection i) bind) {
    _dependencies[T] = bind;
  }

  void cleanModule() {
    _dependencies.clear();
  }

  T call<T>() => get<T>();

  T get<T>() {
    if (_dependencies.containsKey(T)) {
      return _dependencies[T]!(this);
    } else {
      throw Exception('injection not found. [$T]');
    }
  }
}

_Injection getInjection() {
  return _Injection();
}

final sl = getInjection();
