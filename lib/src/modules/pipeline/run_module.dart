import 'package:slidy/di/injection.dart';
import 'package:slidy/src/modules/pipeline/domain/usecase/execute_script.dart';
import 'package:slidy/src/modules/pipeline/domain/usecase/load_slidy_pipeline.dart';
import 'package:slidy/src/modules/pipeline/domain/usecase/resolve_variables.dart';

import 'domain/services/yaml_reader_service.dart';
import 'infra/services/yaml_reader_service.dart';

void RunModule() {
  sl
    //domain
    ..register<LoadSlidyPipeline>((i) => LoadSlidyPipelineImpl(i()))
    ..register<ResolveVariables>((i) => ResolveVariablesImpl())
    ..register<ExecuteStep>((i) => ExecuteStepImpl())
    //infra
    ..register<YamlReaderService>((i) => YamlReaderServiceImpl());
}
