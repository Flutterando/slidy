import 'dart:io';

void create(String projectName, String projectDescription, String projectOrg,
    bool isKotlin, bool isSwift) {
  startFlutterCreate(
      projectName, projectDescription, projectOrg, isKotlin, isSwift);
}

void startFlutterCreate(String projectName, String projectDescription,
    String projectOrg, bool isKotlin, bool isSwift) {
  List<String> flutterArgs = createFlutterArgs(
      projectName, projectDescription, projectOrg, isKotlin, isSwift);

  Process.start("flutter", flutterArgs, runInShell: true).then((process) {
    stdout.addStream(process.stdout);
    stderr.addStream(process.stderr);
    process.exitCode.then((exit) {
      if (exit == 0) {
        startSlidyCreate(projectName);
      }
    });
  });
}

void startSlidyCreate(String projectName) {
  Process.start("slidy", ["start", "-f"],
          runInShell: true, workingDirectory: "./$projectName")
      .then((processSlidy) {
    stdout.addStream(processSlidy.stdout);
    stderr.addStream(processSlidy.stderr);
    processSlidy.exitCode.then((exit) {
      if (exit == 0) {
        Process.start("flutter", ["packages", "get"],
                runInShell: true, workingDirectory: "./$projectName")
            .then((process) {
          stdout.addStream(process.stdout);
          stderr.addStream(process.stderr);
        });
      }
    });
  });
}

List<String> createFlutterArgs(String projectName, String projectDescription,
    String projectOrg, bool isKotlin, bool isSwift) {
  projectDescription = projectDescription == null
      ? "A new Flutter project. Created by Slidy"
      : projectDescription;
  projectOrg = projectOrg == null ? "com.example" : projectOrg;

  var flutterArgs = ["create"];
  flutterArgs.add("--no-pub");
  if (isKotlin) {
    flutterArgs.add("-a");
    flutterArgs.add("kotlin");
  }
  if (isSwift) {
    flutterArgs.add("-i");
    flutterArgs.add("swift");
  }

  flutterArgs.add("--project-name");
  flutterArgs.add("$projectName");

  if (projectDescription.isNotEmpty) {
    flutterArgs.add("--description");
    flutterArgs.add("'$projectDescription'");
  }

  if (projectOrg.isNotEmpty) {
    flutterArgs.add("--org");
    flutterArgs.add("$projectOrg");
  }

  flutterArgs.add(projectName);
  return flutterArgs;
}
