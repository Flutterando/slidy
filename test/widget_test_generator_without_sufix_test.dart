import 'package:slidy/src/templates/templates.dart';
import 'package:test/test.dart';

main() {
  test("widgetTestGeneratorWithoutSuffix", () async {
  var result = widgetTestGeneratorWithoutSuffix("RoundedButton", "slidy_samples", "lib/app/modules/start/widgets/rounded_button/rounded_button.dart", null , null);
    expect(true, result != null && result != "");
  });
}
