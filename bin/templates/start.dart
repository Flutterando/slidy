import 'package:slidy/src/core/models/custom_file.dart';

final _mainTemplate = ''' 
main: |
  import 'package:flutter/material.dart';
  import 'package:flutter_modular/flutter_modular.dart';
  
  import 'app/app_module.dart';
  import 'app/app_widget.dart';
  
  void main() => runApp(ModularApp(module: AppModule(), child: AppWidget()));
  
app_module: |
  import 'package:flutter_modular/flutter_modular.dart';
  
  import 'modules/home/home_module.dart';
  
  class AppModule extends Module {
    @override
    final List<Bind> binds = [];
  
    @override
    final List<ModularRoute> routes = [
      ModuleRoute(Modular.initialRoute, module: HomeModule()),
    ];
  
  }

app_widget: |
  import 'package:flutter/material.dart';
  import 'package:flutter_modular/flutter_modular.dart';
  
  class AppWidget extends StatelessWidget {
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Flutter Slidy',
        theme: ThemeData(primarySwatch: Colors.blue),
      ).modular();
    }
  }

home_page: |
  import 'package:flutter/material.dart';
   
  class HomePage extends StatefulWidget {
    final String title;
    const HomePage({Key? key, this.title = 'Home'}) : super(key: key);
   
    @override
    _HomePageState createState() => _HomePageState();
  }
   
  class _HomePageState extends State<HomePage> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: <Widget>[],
        ),
      );
    }
  }

home_module: |
  import 'package:flutter_modular/flutter_modular.dart';
   
  import 'home_page.dart';
   
  class HomeModule extends Module {
    @override
    final List<Bind> binds = [];
   
    @override
    final List<ModularRoute> routes = [
      ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
    ];
  }

mobx: |
  import 'package:mobx/mobx.dart';
  
  part 'home_store.g.dart';
  
  class HomeStore = HomeStoreBase with _\$HomeStore;
  
  abstract class HomeStoreBase with Store {
    @observable
    int counter = 0;
  
    Future<void> increment() async {
      counter = counter + 1;
    }
  }

mobx_g: |
  // GENERATED CODE DO NOT MODIFY BY HAND
  
  part of 'home_store.dart';
  
  // **************************************************************************
  // StoreGenerator
  // **************************************************************************
  
  // ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic
  
  mixin _\$HomeStore on HomeStoreBase, Store {
    final _\$counterAtom = Atom(name: 'HomeStoreBase.counter');
  
    @override
    int get counter {
      _\$counterAtom.reportRead();
      return super.counter;
    }
  
    @override
    set counter(int value) {
      _\$counterAtom.reportWrite(value, super.counter, () {
        super.counter = value;
      });
    }
  
    @override
    String toString() {
      return 'counter: \${counter}';
    }
  }

cubit: |
  import 'package:flutter_bloc/flutter_bloc.dart';
  
  class CounterCubit extends Cubit<int> {
    CounterCubit() : super(0);
  
    void increment() => emit(state + 1);
    void decrement() => emit(state - 1);
  }

home_page_cubit: |
  import 'package:flutter/material.dart';
  import 'package:flutter_bloc/flutter_bloc.dart';
  import 'package:flutter_modular/flutter_modular.dart';
  
  import 'counter_cubit.dart';
  
  class HomePage extends StatefulWidget {
    @override
    _HomePageState createState() => _HomePageState();
  }
  
  class _HomePageState extends State<HomePage> {
    final CounterCubit _counterCubit = Modular.get();
  
    @override
    void dispose() {
      _counterCubit.close();
      super.dispose();
    }
  
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(title: Text("Home")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              child: Icon(Icons.remove),
              onPressed: _counterCubit.decrement,
            ),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: _counterCubit.increment,
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Button Tapped:"),
              BlocBuilder<CounterCubit, int>(
                bloc: _counterCubit,
                builder: (context, count) {
                  return Text(
                    "\$count",
                    style: Theme.of(context).textTheme.headline3,
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }

home_module_cubit: |
  import 'package:flutter_modular/flutter_modular.dart';
  
  import 'counter_cubit.dart';
  import 'home_page.dart';
  
  class HomeModule extends Module {
    @override
    final List<Bind> binds = [
      Bind.lazySingleton((i) => CounterCubit()),
    ];
  
    @override
    final List<ModularRoute> routes = [
      ChildRoute(Modular.initialRoute, child: (context, args) => HomePage()),
    ];
  }

rx_dart: |
  import 'package:flutter_modular/flutter_modular.dart';
  import 'package:rxdart/rxdart.dart';
  
  class HomeController extends Disposable {
    var _controller = BehaviorSubject.seeded(0);
  
    HomeController() {
      counterStream = _controller.stream;
    }
  
    late Stream<int> counterStream;
  
    void increment() {
      _controller.add(_controller.value! + 1);
    }
  
    @override
    void dispose() {
      _controller.close();
    }
  }

triple: |
  import 'package:flutter_triple/flutter_triple.dart';
  
  class HomeStore extends NotifierStore<Exception, int> {
    HomeStore() : super(0);
  
    Future<void> increment() async {
      setLoading(true);
  
      await Future.delayed(Duration(seconds: 1));
  
      int value = state + 1;
      if (value < 5) {
        update(value);
      } else {
        setError(Exception('Error: state not can be > 4'));
      }
  
      setLoading(false);
    }
  }

home_page_triple: |
  import 'package:flutter/material.dart';
  import 'package:flutter_modular/flutter_modular.dart';
  import 'package:flutter_triple/flutter_triple.dart';
  import 'home_store.dart';
  
  class HomePage extends StatefulWidget {
    final String title;
    const HomePage({Key? key, this.title = "Home"}) : super(key: key);
  
    @override
    _HomePageState createState() => _HomePageState();
  }
  
  class _HomePageState extends ModularState<HomePage, HomeStore> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body: ScopedBuilder<HomeStore, Exception, int>(
          store: store,
          onState: (_, counter) {
            return Padding(
              padding: EdgeInsets.all(10),
              child: Text('\$counter'),
            );
          },
          onError: (context, error) => Center(
            child: Text(
              'Too many clicks',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            store.increment();
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }

home_module_triple: |
   import 'package:flutter_modular/flutter_modular.dart';
   import '../home/home_store.dart'; 
   
   import 'home_page.dart';
    
   class HomeModule extends Module {
     @override
     final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    ];
   
    @override
    final List<ModularRoute> routes = [
      ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
    ];
   }

home_page_mobx: |
  import 'package:flutter/material.dart';
  import 'package:flutter_mobx/flutter_mobx.dart';
  import 'package:flutter_modular/flutter_modular.dart';
  import 'home_store.dart';
  
  class HomePage extends StatefulWidget {
    final String title;
    const HomePage({Key? key, this.title = "Home"}) : super(key: key);
  
    @override
    _HomePageState createState() => _HomePageState();
  }
  
  class _HomePageState extends ModularState<HomePage, HomeStore> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body: Observer(
          builder: (context) => Text('\${store.counter}'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            store.increment();
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }

home_module_mobx: |
   import 'package:flutter_modular/flutter_modular.dart';
   import '../home/home_store.dart'; 
   
   import 'home_page.dart';
    
   class HomeModule extends Module {
     @override
     final List<Bind> binds = [
    Bind.lazySingleton((i) => HomeStore()),
    ];
   
    @override
    final List<ModularRoute> routes = [
      ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
    ];
   }

home_page_rx_dart: |
  import 'package:flutter/material.dart';
  import 'package:flutter_modular/flutter_modular.dart';
  import 'home_controller.dart';
  
  class HomePage extends StatefulWidget {
    final String title;
    const HomePage({Key? key, this.title = "Home"}) : super(key: key);
  
    @override
    _HomePageState createState() => _HomePageState();
  }
  
  class _HomePageState extends ModularState<HomePage, HomeController> {
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Counter'),
        ),
        body: StreamBuilder(
          stream: store.counterStream,
          builder: (context, snapshot) => Text('\${snapshot.data}'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            store.increment();
          },
          child: Icon(Icons.add),
        ),
      );
    }
  }

home_module_rx_dart: |
  import 'package:flutter_modular/flutter_modular.dart';
  
  import 'home_controller.dart';
  import 'home_page.dart';
  
  class HomeModule extends Module {
    @override
    final List<Bind> binds = [
      Bind.lazySingleton((i) => HomeController()),
    ];
  
    @override
    final List<ModularRoute> routes = [
      ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
    ];
  }
''';

final mainFile = CustomFile(yaml: _mainTemplate);
