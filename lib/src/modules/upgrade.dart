import 'dart:convert';
import 'dart:io';

void upgrade() {
  var isFlutterDart = true;

  if (Platform.isWindows) {
    final process = Process.runSync('where', ['slidy'], runInShell: true);

    isFlutterDart =
        process.stdout.toString().contains('flutter\\.pub-cache\\bin\\slidy');
  } else {
    final process = Process.runSync('which', ['slidy'], runInShell: true);
    isFlutterDart =
        process.stdout.toString().contains('flutter/.pub-cache/bin/slidy');
  }

  if (isFlutterDart) {
    print('Upgrade in Flutter Dart VM');
    Process.runSync('flutter', ['pub', 'global', 'activate', 'slidy'],
        runInShell: true);
  } else {
    print('Upgrade in Dart VM');
    Process.runSync('pub', ['global', 'activate', 'slidy'], runInShell: true);
  }

  final process =
      Process.runSync('slidy', ['-v'], runInShell: true, stdoutEncoding: utf8);
  print(process.stdout);
}
