## 4.0.0+8
- Added Pipeline.
- Fix generator

## 3.2.2
- Instalation in choco, homebrew and github release
## 3.2.1+1

- Execute commands faster 🔥

## 3.2.0+1
- **slidy run** improve statement error
- New Interactive slidy run. Type only **slidy run** to view all avaliable scripts commands in your pubspec
## 3.1.0
 - Generate Module -c IS BACK!
 ```dart
 slidy g m modules/profile -c
//generate Module, Controller and Page
 ```
 - New YAML Reader.
 - New FLAG to Page --routing
 ```dart
 slidy g page path/home --routing /home
 //Add a new ChildRoute in parent Module
 ```
- Slidy run works again.
- Many errors were happening because the old YAML Reader system went down. We replaced that and Slidy is back.


## 3.0.2
- Fix slidy run
- Fix slidy install
- Fix template error
- Fix uninstall
- Fix unknown command

## 3.0.0
- complete rework!
- Added Clean Arch templates (usecase and datasource).

## 2.1.2+2
- Algumas correções no import por referencia no module [#170](https://github.com/Flutterando/slidy/pull/170)
- Correções no Start e Scripts adds [#168](https://github.com/Flutterando/slidy/pull/168)
- fix: path to add script on pubspec.yaml [#172](https://github.com/Flutterando/slidy/pull/172)
- fix console message when creating a TestFile [#173](https://github.com/Flutterando/slidy/pull/173)
- Correção de bug ao realizar slidy start para gerar gitignore e scripts [#176](https://github.com/Flutterando/slidy/pull/176)

## 2.1.1
- Add annotation @JsonSerializable to when create a model [#144](https://github.com/Flutterando/slidy/pull/144)
- Added "slidy localization" command [#146](https://github.com/Flutterando/slidy/pull/146)
- New Flag -i to generate interface [#146](https://github.com/Flutterando/slidy/pull/146)
```
slidy g repository /modules/home/repositories/post -t
```
New Features in Module:
```
-r => generate with Repository
-i => generate with Repository and Interface to repository
Slidy g m modules/MyModule -c -r -i
```
- Fix imports [#154](https://github.com/Flutterando/slidy/pull/154)
- Fix order of commands in documentation [#159](https://github.com/Flutterando/slidy/pull/159)
- Some fixes for effective dart pattern [#160](https://github.com/Flutterando/slidy/pull/160)

- Fix bugs

## 2.0.1+1
- PREVIEW: Added Localization (i18n) generate
- Added jsonSerializable in Model generate
- Fix bugs

## 2.0.0+1
WE GET SLIDY VERSION 2
Thanks to everyone in the community

- Added "Revert" command
```dart
slidy revert
```
Reverse the last generation command.

## 1.5.3
- Fixed error in generated page in RXDart project

## 1.5.2
- Generate Store Command
  ```
  slidy generate store /path/store 
  ```
- Slidy create -m (state_managent) -p
- Internal Core Modification
- Now using ModularState in Generate Pages;


## 1.4.12
- Create module withless named route system **--noroute**:
  ```
  slidy generate module /path/module --noroute [-n]
  ```
- Added flag -p (provider system), -s (state management), -f (force) to start command (by [lukelima](https://github.com/lukelima));
 ```
  slidy start -p flutter_modular -s mobx -f 
```

## 1.4.7
- Create reactive model template with **--rx**:
  ```
  slidy generate model /path/model_name --rx
  ```
- flutter_modular as default provider;
- Fix model template;

## 1.4.2+1
- Fix test file generate error.

## 1.4.1
- Slidy CLI Interative
- Fix slidy create erro

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