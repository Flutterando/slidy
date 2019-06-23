import 'package:slidy/slidy.dart';

Map<String, Function> methods = {
  'start': (args) => start(args),
  'generate': (args) => Generate(args), 'g': (args) => Generate(args),
  'update': (args) => update(args),
  'upgrade': (args) => upgrade(),
  'install': (args) => install(args),
  'unistall': (args) => unistall(args),
  '--help': (args) => help(),
  '--version': (args) => version(),

};

main(List<String> args) async {
  if (args.isEmpty) {
    print("Slidy");
    return;
  }

  methods.containsKey(args.first)
      ? methods[args.first](args)
      : print("Invalid command");
}
