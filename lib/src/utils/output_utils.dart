import 'package:ansicolor/ansicolor.dart';

AnsiPen red = new AnsiPen()..red(bold: true);
AnsiPen green = new AnsiPen()..green(bold: true);
AnsiPen white = new AnsiPen()..white(bold: true);
AnsiPen yellow = new AnsiPen()..yellow(bold: true);

void success(msg) => print(green("SUCCESS: $msg"));
void warn(msg)=> print(yellow("WARN: $msg"));
void error(msg) => print(red("ERROR: $msg"));
void msg(msg) => print(white(msg));
