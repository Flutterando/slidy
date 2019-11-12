import 'dart:io';

import 'package:slidy/src/utils/file_utils.dart';
import 'package:test/test.dart';

void main() {
  setUp(() {});

  // group('createStaticFile Test', () {
  //   test("createStaticFile", () {
  //     createStaticFile("home.dart", "content");
  //   });
  // });

 group('findModule Test', () {
     test("findModule", () {
        expect(findModule("slidy.dart"),  isA<File>());      
     });
   });  

group('search Test', () {
     test("search", () {
       var directory = Directory("D:/gitTemp/slidy/example/lib/app/pages/home/home_module.dart"); 
        expect(search(directory),  null);      
     });
   }); 
   
}
