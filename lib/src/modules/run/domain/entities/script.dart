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

enum TypeEnum {
  command([]),
  bash(['bash', '-c']),
  sh(['sh', '-c']),
  zsh(['zsh', '-c']),
  powershell(['pwsh', '-c']);

  final List<String> commands;
  const TypeEnum(this.commands);
}

class Script {
  final String name;
  final String description;
  final String workingDirectory;
  final TypeEnum type;
  late final List<Step> steps;

  Script({
    required this.name,
    required this.type,
    this.description = '',
    String? run,
    this.workingDirectory = '.',
    List<Step>? steps,
  }) {
    assert(run != null || steps != null, 'use [command] or [steps] field.');
    assert(!(run != null && steps != null), 'Don\'t use command and steps together.');

    this.steps = run != null ? [Step(run: run, type: type)] : steps!;
  }

  Script copyWith({
    String? name,
    String? description,
    String? workingDirectory,
    List<Step>? steps,
    TypeEnum? type,
  }) {
    return Script(
      type: type ?? this.type,
      name: name ?? this.name,
      description: description ?? this.description,
      workingDirectory: workingDirectory ?? this.workingDirectory,
      steps: steps ?? this.steps,
    );
  }
}

class Step {
  final String? name;
  final String run;
  final String description;
  final String workingDirectory;
  final TypeEnum type;

  Step({
    required this.run,
    required this.type,
    this.name,
    this.description = '',
    this.workingDirectory = '.',
  });

  Step copyWith({
    String? name,
    String? run,
    String? description,
    String? workingDirectory,
    TypeEnum? type,
  }) {
    return Step(
      name: name ?? this.name,
      type: type ?? this.type,
      run: run ?? this.run,
      description: description ?? this.description,
      workingDirectory: workingDirectory ?? this.workingDirectory,
    );
  }
}
