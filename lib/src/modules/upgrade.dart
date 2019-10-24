import 'dart:convert';
import 'dart:io';

void upgrade() {

  bool isFlutterDart = true;

  if(Platform.isWindows){
    // var process = Process.runSync("where", ["slidy"], runInShell: true);
    // isFlutterDart = process.stdout.toString().contains("flutter/.pub-cache/bin/slidy");
  } else {
    var process = Process.runSync("which", ["slidy"], runInShell: true);
    isFlutterDart = process.stdout.toString().contains("flutter/.pub-cache/bin/slidy");
  }

  if(isFlutterDart){
    print("Upgrade in Flutter Dart VM");
    Process.runSync("flutter", ["pub", "global", "activate", "slidy"], runInShell: true);
  } else {
    print("Upgrade in Dart VM");
    Process.runSync("pub", ["global", "activate", "slidy"], runInShell: true);
  }

  var process =
      Process.runSync("slidy", ["-v"], runInShell: true, stdoutEncoding: utf8);
  print(process.stdout);
}
