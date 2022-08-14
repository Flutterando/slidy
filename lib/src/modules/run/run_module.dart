import 'package:slidy/di/injection.dart';
import 'package:slidy/src/modules/run/domain/usecase/execute_script.dart';
import 'package:slidy/src/modules/run/domain/usecase/load_slidy_pipeline.dart';
import 'package:slidy/src/modules/run/domain/usecase/resolve_script.dart';

import 'domain/services/yaml_reader_service.dart';
import 'infra/services/yaml_reader_service.dart';

void RunModule() {
  sl
    //domain
    ..register<LoadSlidyPipeline>((i) => LoadSlidyPipelineImpl(i()))
    ..register<ResolveScript>((i) => ResolveScriptImpl())
    ..register<ExecuteScript>((i) => ExecuteScriptImpl())
    //infra
    ..register<YamlReaderService>((i) => YamlReaderServiceImpl());
}
