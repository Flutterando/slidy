import 'package:slidy/src/modules/run/domain/entities/script.dart';
import 'package:slidy/src/modules/run/domain/entities/slidy_pipeline_v1.dart';
import 'package:slidy/src/modules/run/domain/usecase/resolve_script.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

void main() {
  test('resolve script ...', () {
    final usecase = ResolveScriptImpl();

    final pipeline = SlidyPipelineV1(
      localVariables: {
        'var1': 'test',
      },
      systemVariables: {
        'var1': 'testGlobal',
      },
      scripts: {
        'command': Script(
          name: 'command',
          command: r'command ${Local.var1} e ${System.env.var1}',
          type: TypeEnum.command,
        ),
      },
    );

    final result = usecase.call('command', pipeline);
    expect(result.isRight(), true);
    final script = result.getOrElse((l) => throw l);
    expect(script.steps.first.run, 'command test e testGlobal');
  });
}
