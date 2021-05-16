import 'package:grinder/grinder.dart';
import 'package:cli_pkg/cli_pkg.dart' as pkg;

void main(List<String> args) {
  pkg.name.value = 'slidy';
  pkg.humanName.value = 'slidy';
  pkg.githubUser.value = 'flutterando';
  pkg.homebrewRepo.value = 'flutterando/homebrew-slidy';

  pkg.addAllTasks();
  grind(args);
}
