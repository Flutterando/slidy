import 'dart:convert';
import 'dart:io';

void upgrade() {

  //C:\Users\bwolf\AppData\Roaming\Pub\Cache\bin\slidy.bat
  //C:\Users\azeve\AppData\Roaming\Pub\Cache\bin\slidy.bat
  bool isFlutterDart = false;

  if(Platform.isWindows){
    print("Upgrade in Windows");
    var process = Process.runSync("where", ["slidy"], runInShell: true);
  } else {
    var process = Process.runSync("which", ["slidy"], runInShell: true);
    isFlutterDart = process.stdout.toString().contains("flutter/.pub-cache/bin/slidy");
  }
  if(isFlutterDart){
    Process.runSync("flutter", ["pub", "global", "activate", "slidy"], runInShell: true);
  } else {
    Process.runSync("pub", ["global", "activate", "slidy"], runInShell: true);
  }

  var process =
      Process.runSync("slidy", ["-v"], runInShell: true, stdoutEncoding: utf8);
  print(process.stdout);
}
