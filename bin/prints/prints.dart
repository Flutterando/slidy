import 'package:ansicolor/ansicolor.dart';
import 'package:either_dart/either.dart';
import 'package:slidy/slidy.dart';

AnsiPen red = AnsiPen()..red(bold: true);
AnsiPen green = AnsiPen()..green(bold: true);
AnsiPen white = AnsiPen()..white(bold: true);
AnsiPen yellow = AnsiPen()..yellow(bold: true);

void success(msg) => print(green('SUCCESS: $msg'));
void title(msg) => print(green('$msg'));
void warn(msg) => print(yellow('WARN: $msg'));
void error(msg) => print(red('ERROR: $msg'));
void msg(msg) => print(white(msg));

void execute(Either<SlidyError, SlidyProccess> either) {
  either.fold((left) {
    error(left.message);
  }, (right) {
    success(right.result);
  });
}
