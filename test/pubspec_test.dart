import 'dart:io';

import 'package:slidy/src/utils/pubspec.dart';
import 'package:test/test.dart';

main() {
  test("Loading pubspec", () async {
    final pub = await PubSpec.load(Directory(""));
    expect(pub, isA<PubSpec>());
  });

  test("Loading pubspec get name", () async {
    final pub = await PubSpec.load(Directory(""));
    expect(pub.name, "slidy");
  });

  test("Loading pubspec get dependencies", () async {
    final pub = await PubSpec.load(Directory(""));
    expect(pub.dependencies['ansicolor'], "^1.0.2");
  });

  test("Loading pubspec get Devdependencies", () async {
    final pub = await PubSpec.load(Directory(""));
    expect(pub.devDependencies['test'], "^1.9.4");
  });

  test("Copy", () async {
    final pub = await PubSpec.load(Directory(""));
    pub.devDependencies['test2'] = "1.2.3";
    expect(
        pub.copy(devDependencies: pub.devDependencies).devDependencies['test2'],
        "1.2.3");
  });

  // test("Save", () async {
  //   final pub = await PubSpec.load(Directory(""));
  //   pub.devDependencies['test2'] = "1.2.3";
  //   var newPub = pub.copy(devDependencies: pub.devDependencies);
  //   await newPub.save(Directory(""));
  //   final pubAgain = await PubSpec.load(Directory(""));
  //   expect(pubAgain.devDependencies['test2'], "1.2.3");
  // });
}
