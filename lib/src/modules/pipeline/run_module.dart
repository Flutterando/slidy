import 'package:slidy/src/core/modular/module.dart';
import 'package:slidy/src/modules/pipeline/domain/usecase/execute_script.dart';
import 'package:slidy/src/modules/pipeline/domain/usecase/load_slidy_pipeline.dart';
import 'package:slidy/src/modules/pipeline/domain/usecase/resolve_variables.dart';

import '../../core/modular/bind.dart';
import 'domain/services/yaml_reader_service.dart';
import 'infra/services/yaml_reader_service.dart';

class RunModule extends Module {
  @override
  List<Bind> get binds => [
        //domain
        Bind.singleton<LoadSlidyPipeline>((i) => LoadSlidyPipelineImpl(i()), export: true),
        Bind.singleton<ResolveVariables>((i) => ResolveVariablesImpl(), export: true),
        Bind.singleton<ExecuteStep>((i) => ExecuteStepImpl(), export: true),
        //infra
        Bind.singleton<YamlReaderService>((i) => YamlReaderServiceImpl(), export: true),
      ];
}
