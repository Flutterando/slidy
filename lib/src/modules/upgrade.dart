import 'dart:convert';
import 'dart:io';

void upgrade() {
  Process.runSync("pub", ["global", "activate", "slidy"], runInShell: true);
  var process = Process.runSync("slidy", ["-v"], runInShell: true, stdoutEncoding: utf8);
  print(process.stdout);
}
