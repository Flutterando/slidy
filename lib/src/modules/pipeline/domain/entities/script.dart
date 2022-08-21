/*
scripts:
  simple: flutter doctor
  my-script:
    name: myscript
    description: my great desc.
    run: flutter clean
  my-script2:
    description: my great desc.
    steps:
      - name: Clean
        run: flutter clean
      - name: Get
        run: flutter pub get

*/

import 'dart:io';

enum ShellEnum {
  command([], []),
  bash(['bash', '-c'], ['wsl']),
  sh(['sh', '-c'], ['wsl']),
  zsh(['zsh', '-c'], ['wsl']),
  pwsh(['pwsh', '-c'], ['powershell', '-c']);

  final List<String> _commands;
  final List<String> _windowsCommands;
  const ShellEnum(this._commands, this._windowsCommands);

  List<String> get commands => Platform.isWindows ? _windowsCommands : _commands;
}

class Script {
  final String name;
  final String description;
  final String workingDirectory;
  final ShellEnum shell;
  final Map<String, String>? environment;
  late final List<Step> steps;

  Script({
    required this.name,
    required this.shell,
    this.description = '',
    String? run,
    this.environment,
    this.workingDirectory = '.',
    List<Step>? steps,
  }) {
    assert(run != null || steps != null, 'use [command] or [steps] field.');
    assert(!(run != null && steps != null), 'Don\'t use command and steps together.');

    this.steps = run != null ? [Step(run: run, shell: shell, environment: environment)] : steps!;
  }

  Script copyWith({
    String? name,
    String? description,
    String? workingDirectory,
    List<Step>? steps,
    ShellEnum? shell,
    Map<String, String>? environment,
  }) {
    return Script(
      shell: shell ?? this.shell,
      name: name ?? this.name,
      description: description ?? this.description,
      environment: environment ?? this.environment,
      workingDirectory: workingDirectory ?? this.workingDirectory,
      steps: steps ?? this.steps,
    );
  }
}

class Step {
  final String? name;
  final String run;
  final String description;
  final String? condition;
  final String workingDirectory;
  final ShellEnum shell;
  final Map<String, String>? environment;

  Step({
    required this.run,
    required this.shell,
    this.name,
    this.condition,
    this.description = '',
    this.workingDirectory = '.',
    this.environment,
  });

  Step copyWith({
    String? name,
    String? run,
    String? description,
    String? workingDirectory,
    String? condition,
    Map<String, String>? environment,
    ShellEnum? shell,
  }) {
    return Step(
      name: name ?? this.name,
      shell: shell ?? this.shell,
      run: run ?? this.run,
      condition: condition ?? this.condition,
      environment: environment ?? this.environment,
      description: description ?? this.description,
      workingDirectory: workingDirectory ?? this.workingDirectory,
    );
  }
}
