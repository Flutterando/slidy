import 'dart:convert';
import 'dart:io';

import 'command_base.dart';
import '../prints/prints.dart' as output;

class UpgradeCommand extends CommandBase {
  @override
  final name = 'upgrade';
  @override
  final description = 'Upgrade the Slidy version';

  @override
  void run() {
    try {
      output.title('Upgrading Slidy...');
      Process.runSync('pub', ['global', 'activate', 'slidy'], runInShell: true);
      output.success('upgraded!');

      var process = Process.runSync('slidy', ['-v'], runInShell: true, stdoutEncoding: utf8);
      print(process.stdout);
    } catch (e) {
      output.error('Failure upgrade :(');
    }
  }

  @override
  String? get invocationSuffix => null;
}
