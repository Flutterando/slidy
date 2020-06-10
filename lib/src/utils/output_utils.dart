import 'package:ansicolor/ansicolor.dart';

AnsiPen red = AnsiPen()..red(bold: true);
AnsiPen green = AnsiPen()..green(bold: true);
AnsiPen white = AnsiPen()..white(bold: true);
AnsiPen yellow = AnsiPen()..yellow(bold: true);

void success(String msg) => print(green('SUCCESS: $msg'));
void title(String msg) => print(green('$msg'));
void warn(String msg) => print(yellow('WARN: $msg'));
void error(String msg) => print(red('ERROR: $msg'));
void msg(String msg) => print(white(msg));
