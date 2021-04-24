import 'dart:async';
import 'dart:convert';

import 'package:either_dart/src/either.dart';

import 'package:slidy/src/core/entities/slidy_process.dart';
import 'package:slidy/src/modules/pipelines/domain/errors/errors.dart';

import 'pipeline.dart';

class PipelineV1 extends Pipeline {
  final String name;
  final String version;
  final List<JobV1> jobs;

  PipelineV1(FutureOr<Either<PipelineError, SlidyProccess>> Function(Pipeline pipeline) usecase, {required this.name, this.version = 'v1', this.jobs = const []}) : super(usecase);

  factory PipelineV1.fromMap(Map map, FutureOr<Either<PipelineError, SlidyProccess>> Function(Pipeline pipeline) usecase) {
    final jobs = <JobV1>[];

    for (var key in map.keys) {
      if (key == 'name' || key == 'version') {
        continue;
      }

      final job = JobV1.fromMap({'key': key, 'name': map[key]['name'], 'steps': map[key]['steps']});
      jobs.add(job);
    }

    return PipelineV1(
      usecase,
      name: map['name'],
      version: map['version'],
      jobs: jobs,
    );
  }

  factory PipelineV1.fromJson(
    String source,
    FutureOr<Either<PipelineError, SlidyProccess>> Function(Pipeline pipeline) usecase,
  ) =>
      PipelineV1.fromMap(json.decode(source), usecase);
}

class JobV1 {
  final String key;
  final String? name;
  final List<StepV1> steps;

  const JobV1({required this.key, this.name, this.steps = const []});

  factory JobV1.fromMap(Map map) {
    return JobV1(
      key: map['key'],
      name: map['name'],
      steps: map['steps'] == null ? [] : List<StepV1>.from(map['steps']?.map((x) => StepV1.fromMap(x))),
    );
  }

  factory JobV1.fromJson(String source) => JobV1.fromMap(json.decode(source));
}

class StepV1 {
  final String id;
  final List<String> commands;
  final GenerateV1? generate;

  const StepV1({required this.id, this.commands = const [], this.generate});

  factory StepV1.fromMap(Map map) {
    return StepV1(
      id: map['id'],
      commands: map['commands'] == null ? [] : List<String>.from(map['commands']),
      generate: GenerateV1.fromMap(map['generate']),
    );
  }

  factory StepV1.fromJson(String source) => StepV1.fromMap(json.decode(source));
}

class GenerateV1 {
  final String path;
  final String file;
  final ModuleInjectionV1? moduleInjection;
  final String? run;

  const GenerateV1({this.run, required this.path, required this.file, this.moduleInjection});

  factory GenerateV1.fromMap(Map map) {
    return GenerateV1(
      path: map['path'],
      file: map['file'],
      moduleInjection: ModuleInjectionV1.fromMap(map['module_injection']),
      run: map['run'],
    );
  }

  factory GenerateV1.fromJson(String source) => GenerateV1.fromMap(json.decode(source));
}

class ModuleInjectionV1 {
  final ModuleInjectionV1Type type;
  final String value;

  const ModuleInjectionV1({required this.type, required this.value});

  factory ModuleInjectionV1.fromMap(Map map) {
    return ModuleInjectionV1(
      type: ModuleInjectionV1Type.values.firstWhere((element) => map['type'] == element.toString().replaceFirst('ModuleInjectionV1Type.', '')),
      value: map['value'],
    );
  }

  factory ModuleInjectionV1.fromJson(String source) => ModuleInjectionV1.fromMap(json.decode(source));
}

enum ModuleInjectionV1Type { bind, route }
