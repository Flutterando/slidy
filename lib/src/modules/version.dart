import 'package:slidy/src/utils/utils.dart';

void version() async {
  String version = await getVersion();
  //String version = '0.0.13';
  print('''

███████╗██╗     ██╗██████╗ ██╗   ██╗     ██████╗██╗     ██╗
██╔════╝██║     ██║██╔══██╗╚██╗ ██╔╝    ██╔════╝██║     ██║
███████╗██║     ██║██║  ██║ ╚████╔╝     ██║     ██║     ██║
╚════██║██║     ██║██║  ██║  ╚██╔╝      ██║     ██║     ██║
███████║███████╗██║██████╔╝   ██║       ╚██████╗███████╗██║
╚══════╝╚══════╝╚═╝╚═════╝    ╚═╝        ╚═════╝╚══════╝╚═╝                                             
''');
  print("CLI package manager and template for Flutter");
  print("");
  print("Slidy version: $version");
}
