import 'dart:convert';
import 'dart:io';

import 'package:mocktail/mocktail.dart';
import 'package:slidy/src/core/models/pubspec.dart';
import 'package:slidy/src/core/services/pubspec_service_impl.dart';
import 'package:test/test.dart';

class FileMock extends Mock implements File {
  String savedFile = '';

  @override
  Future<File> writeAsString(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) async {
    savedFile = contents;
    return this;
  }
}

class FileRealMock extends Mock implements File {
  String savedFile = '';

  @override
  Future<File> writeAsString(String contents, {FileMode mode = FileMode.write, Encoding encoding = utf8, bool flush = false}) async {
    savedFile = contents;
    return this;
  }
}

void main() {
  final file = FileMock();
  final service = PubspecServiceImpl(yaml: file);
  when(() => file.readAsLines()).thenAnswer((_) async => yaml.split('\n'));
  final fileReal = FileRealMock();
  final serviceReal = PubspecServiceImpl(yaml: fileReal);
  when(() => fileReal.readAsLines()).thenAnswer((_) async => realPubspec.split('\n'));

  test('load yaml', () async {
    final list = await service.loadYaml();
    expect(list, isA<List<Line>>());
  });

  test('get line', () async {
    final line = await service.getLine('test');
    expect(line.value, '2');
  });

  test('added in yaml', () async {
    final list = await service.add(Line(name: 'test2', value: ' added'));
    expect(list, true);
    expect(file.savedFile, yamlAfterSave);
  });

  test('update in yaml', () async {
    final list = await service.add(Line(name: 'test', value: '3'));
    expect(list, true);
    expect(file.savedFile, yamlAfterUpdate);
  });

  test('added package in yaml', () async {
    final list = await service.add(Line.package(name: 'my_package', version: '1.0.0'));
    expect(list, true);
    expect(file.savedFile, yamlAfterSavePackage);
  });

  test('update package', () async {
    await service.add(Line.package(name: 'my_package', version: '1.0.0'));
    expect(file.savedFile, yamlAfterSavePackage);
    final list = await service.add(Line.package(name: 'my_package', version: '1.0.1'));
    expect(list, true);
    expect(file.savedFile, yamlAfterUpdatePackage);
  });

  test('remove package', () async {
    await service.add(Line.package(name: 'my_package', version: '1.0.0'));
    expect(file.savedFile, yamlAfterSavePackage);
    var line = await service.getLine('dependencies');
    (line.value as LineMap).remove('my_package');
    await service.add(line);
    expect(file.savedFile, yamlAfterDeletePackage);
  });

  group('real pubspec', () {
    test('added package in yaml', () async {
      //var line = await serviceReal.getLine('dependencies');
      //line.value['triple'] = Line(name: 'triple', value: '1.0.0');
      // await serviceReal.add(line);
      await serviceReal.add(Line.package(name: 'triple', version: '1.0.0'));
      expect(fileReal.savedFile, realPubspecAdd);
    });
    test('removed package in yaml', () async {
      await serviceReal.add(Line.package(name: 'triple', version: '1.0.0'));
      var line = await serviceReal.getLine('dependencies');
      (line.value as LineMap).remove('triple');
      (line.value as LineMap).remove('cupertino_icons');
      await serviceReal.replace(line);
      expect(fileReal.savedFile, realPubspecRemove);
    });
  });
}

const yaml = '''test: 2
object:
  param1: 1
  param2: 2
dependencies:
  object1:
    sdk: flutter
array:
  - name1
  - name2
  - name3
''';
const yamlAfterUpdate = '''test: 3
object:
  param1: 1
  param2: 2
dependencies:
  object1:
    sdk: flutter
array:
  - name1
  - name2
  - name3''';

const yamlAfterUpdatePackage = '''test: 2
object:
  param1: 1
  param2: 2
dependencies:
  object1:
    sdk: flutter
  my_package: 1.0.1
array:
  - name1
  - name2
  - name3''';

const yamlAfterDeletePackage = '''test: 2
object:
  param1: 1
  param2: 2
dependencies:
  object1:
    sdk: flutter
array:
  - name1
  - name2
  - name3''';

const yamlAfterSave = '''test: 2
object:
  param1: 1
  param2: 2
dependencies:
  object1:
    sdk: flutter
array:
  - name1
  - name2
  - name3
test2:  added''';

const yamlAfterSavePackage = '''test: 2
object:
  param1: 1
  param2: 2
dependencies:
  object1:
    sdk: flutter
  my_package: 1.0.0
array:
  - name1
  - name2
  - name3''';

const realPubspec = """
name: example
description: A new Flutter project.

# The following line prevents the package from being accidentally published to
# pub.dev using `pub publish`. This is preferred for private packages.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev

# The following defines the version and build number for your application.
# A version number is three numbers separated by dots, like 1.2.43
# followed by an optional build number separated by a +.
# Both the version and the builder number may be overridden in flutter
# build by specifying --build-name and --build-number, respectively.
# In Android, build-name is used as versionName while build-number used as versionCode.
# Read more about Android versioning at https://developer.android.com/studio/publish/versioning
# In iOS, build-name is used as CFBundleShortVersionString while build-number used as CFBundleVersion.
# Read more about iOS versioning at
# https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html
version: 1.0.0+1

environment:
  sdk: ">=2.7.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter


  # The following adds the Cupertino Icons font to your application.
  # Use with the CupertinoIcons class for iOS style icons.
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter

# For information on the generic Dart part of this file, see the
# following page: https://dart.dev/tools/pub/pubspec

# The following section is specific to Flutter.
flutter:

  # The following line ensures that the Material Icons font is
  # included with your application, so that you can use the icons in
  # the material Icons class.
  uses-material-design: true

  # To add assets to your application, add an assets section, like this:
  # assets:
  #   - images/a_dot_burr.jpeg
  #   - images/a_dot_ham.jpeg

  # An image asset can refer to one or more resolution-specific "variants", see
  # https://flutter.dev/assets-and-images/#resolution-aware.

  # For details regarding adding assets from package dependencies, see
  # https://flutter.dev/assets-and-images/#from-packages

  # To add custom fonts to your application, add a fonts section here,
  # in this "flutter" section. Each entry in this list should have a
  # "family" key with the font family name, and a "fonts" key with a
  # list giving the asset and other descriptors for the font. For
  # example:
  # fonts:
  #   - family: Schyler
  #     fonts:
  #       - asset: fonts/Schyler-Regular.ttf
  #       - asset: fonts/Schyler-Italic.ttf
  #         style: italic
  #   - family: Trajan Pro
  #     fonts:
  #       - asset: fonts/TrajanPro.ttf
  #       - asset: fonts/TrajanPro_Bold.ttf
  #         weight: 700
  #
  # For details regarding fonts from package dependencies,
  # see https://flutter.dev/custom-fonts/#from-packages
""";

const realPubspecAdd = """name: example
description: A new Flutter project.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev
version: 1.0.0+1
environment:
  sdk: ">=2.7.0 <3.0.0"
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2
  triple: 1.0.0
dev_dependencies:
  flutter_test:
    sdk: flutter
flutter:
  uses-material-design: true""";
const realPubspecRemove = """name: example
description: A new Flutter project.
publish_to: 'none' # Remove this line if you wish to publish to pub.dev
version: 1.0.0+1
environment:
  sdk: ">=2.7.0 <3.0.0"
dependencies:
  flutter:
    sdk: flutter
dev_dependencies:
  flutter_test:
    sdk: flutter
flutter:
  uses-material-design: true""";
