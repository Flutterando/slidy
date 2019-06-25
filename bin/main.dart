import 'package:slidy/slidy.dart';

Map<String, Function> methods = {
  'start': (args) => start(args),
  'generate g': (args) => Generate(args),
  'update': (args) => update(args),
  'upgrade': (args) => upgrade(),
  'install i': (args) => install(args),
  'uninstall': (args) => uninstall(args),
  '--help -h': (args) => help(),
  '--version -v': (args) => version(),
};

main(List<String> args) async {
  if (args.isEmpty) {
    version();
    return;
  }

  String commandName = await getCommandName(args);
  methods.containsKey(commandName)
      ? methods[commandName](args)
      : print("Invalid command");
}

Future<String> getCommandName(List<String> args) async {
  return methods.keys
      .where((x) => x.split(" ").any((y) => y == args.first))
      .first;
}
