import 'package:slidy/src/core/modular/bind.dart';
import 'package:slidy/src/core/modular/module.dart';
import 'package:slidy/src/modules/template_generator/domain/usecases/add_line.dart';
import 'package:slidy/src/modules/template_generator/domain/usecases/create.dart';

class TemplateGeneratorModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.singleton<Create>((i) => CreateImpl(), export: true),
    Bind.singleton<AddLine>((i) => AddLineImpl(), export: true),
  ];
}
