## 1.2.2
- Added command generate model

## 1.2.1
- Fix error install in flutter dart.
- removed dart:mirrors.

## 1.2.0+1
- Added flutter_bloc and mobx support.
 ```
  slidy start --flutter_bloc [-f]
  or
  slidy start --mobx [-m]
 ```
If you have the flutter_bloc or flutter_mobx package in pubspec, the generation of pages, widgets, and bloc defaults to the installed manager default.

- Added flags "--flutter_bloc | -f" and "--mobx | -m" to generate bloc. 
- Added command "generate controller" (to mobx).


## 1.1.4
- Added initModule in tests (check the documentation)

## 1.1.3
- Create unity test widget when generate pages or widgets.
- Flutter Dart 100% compatible
  ```
   flutter pub global activate slidy
  ```

## 1.1.2
- Added "service" command to generate auto disposed and injetable service.
  ```
   slidy generate service path-of-your-file
  ```

## 1.1.0
- Now creating BLoCs or Repositories also creates Unitary Test files.
- Added "test" command to "generate command".
  ```
   slidy generate test path-of-your-file
  ```

## 1.0.0
- added command run, for exec your scripts in pubspec.yaml
- Some commands have been improved for ease of usability
for example the module, page and widget generation command have been shortened.
- Fix errors

## 0.2.1
- Removed folder App for main module.
- File placement changes after "start -c" command.
- The command "start -c" is being optimized to be the initial interface. We are working on the routes.

## 0.2.0
- Added start -c, to start the project with routers, locations, and page structures

## 0.1.2
- Added bloc command create;

## 0.1.1
- Added param 'create';

## 0.0.1
- Initial version, created by Stagehand
