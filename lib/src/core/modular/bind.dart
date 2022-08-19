import 'package:modular_core/modular_core.dart';

class Bind<T extends Object> extends BindContract<T> {
  Bind(
    super.factoryFunction, {
    super.isSingleton,
    super.isLazy,
    super.export,
    super.isScoped,
    super.alwaysSerialized,
    super.onDispose,
    super.selector,
  });

  ///Bind a factory. Always a new constructor when calling Modular.get
  static Bind<T> factory<T extends Object>(
    T Function(Injector i) inject, {
    bool export = false,
  }) {
    return Bind<T>(inject, isSingleton: false, isLazy: true, export: export);
  }

  ///Bind  an already exist 'Instance' of object..
  static Bind<T> instance<T extends Object>(T instance, {bool export = false, dynamic Function(T value)? selector}) {
    return Bind<T>((i) => instance, isSingleton: false, isLazy: true, export: export, selector: selector);
  }

  ///Bind a 'Singleton' class.
  ///Built together with the module.
  ///The instance will always be the same.
  static Bind<T> singleton<T extends Object>(T Function(Injector i) inject, {bool export = false, void Function(T value)? onDispose, dynamic Function(T value)? selector}) {
    return Bind<T>(inject, isSingleton: true, isLazy: false, export: export, onDispose: onDispose, selector: selector);
  }

  ///Create single instance for request.
  static Bind<T> lazySingleton<T extends Object>(T Function(Injector i) inject, {bool export = false, void Function(T value)? onDispose, dynamic Function(T value)? selector}) {
    return Bind<T>(inject, isSingleton: true, isLazy: true, export: export, onDispose: onDispose, selector: selector);
  }

  @override
  BindContract<E> cast<E extends Object>() {
    return Bind<E>(
      factoryFunction as E Function(Injector i),
      alwaysSerialized: alwaysSerialized,
      export: export,
      isLazy: isLazy,
      isSingleton: isSingleton,
      selector: selector != null ? selector as Function(E) : null,
      onDispose: onDispose != null ? onDispose as void Function(E) : null,
    );
  }

  @override
  BindContract<T> copyWith(
      {T Function(Injector i)? factoryFunction,
      bool? isSingleton,
      bool? isLazy,
      bool? export,
      bool? isScoped,
      bool? alwaysSerialized,
      void Function(T value)? onDispose,
      Function(T value)? selector}) {
    return Bind<T>(
      factoryFunction ?? this.factoryFunction,
      alwaysSerialized: alwaysSerialized ?? this.alwaysSerialized,
      export: export ?? this.export,
      isLazy: isLazy ?? this.isLazy,
      isSingleton: isSingleton ?? this.isSingleton,
      selector: selector ?? this.selector,
      onDispose: onDispose ?? this.onDispose,
    );
  }
}
