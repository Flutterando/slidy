import 'dart:io';

import 'package:pubspec/pubspec.dart';
import 'package:test/test.dart';
import 'package:slidy/src/utils/utils.dart';

void main() {
  setUp(() {});

  group('FormatName Test', () {
    test("formatName without undeline", () {
      expect(formatName("home.dart"), "Home");
    });

    test("formatName with undeline", () {
      expect(formatName("home_module.dart"), "HomeModule");
    });
  });

  //  group('ResolveName Test', () {
  //   test("resolveName 1", () {
  //     expect(resolveName("Módulo_Home"), "M_dulo_Home");
  //   });

  //   test("formatName 2", () {
  //     expect(resolveName("home_module.dart"), "HomeModule");
  //   });
  // });

  group('GetPubSpec Test', () {
    test("getPubSpec with directory", () async {
      expect(await getPubSpec(directory: Directory("")), isA<PubSpec>());
    });
    test("getPubSpec without directory", () async {
      expect(await getPubSpec(), isA<PubSpec>());
    });
  });

  group('GetNamePackage Test', () {
    test("getNamePackage 01", () async {
      expect(await getNamePackage(), "slidy");
    });
  });

  group('LibPath Test', () {
    test("libPath 01", () async {
      expect(await libPath("folder/app/home"), "lib/src/folder/app/home");
    });

    test("libPath 02", () async {
      expect(await libPath("command"), "lib/src/command");
    });
  });

  group('ValidateUrl Test', () {
    test("validateUrl 01", () async {
      expect(await validateUrl("https://github.com/flutterando"), true);
    });

    test("validateUrl 02", () async {
      expect(await validateUrl("http://github.com/flutterando"), true);
    });

    test("validateUrl 03", () async {
      expect(await validateUrl("github.com/flutterando"), false);
    });
  });

  
}
