# Slidy

CLI script pipeline, package manager and template generator for Flutter. Generate Modules, Pages, Widgets, BLoCs, Controllers, tests and more.

# Installation

You can get Slidy of many ways.

## choco (only windows)

```bash
choco install slidy
```

## Homebrew (macos and linux)

```bash
brew tap Flutterando/slidy
brew install slidy
```


## Flutter/Dart directly

```bash
 dart pub global activate slidy
```

## Hello world!

After install, exec the slidy version command.
If the command was completed, the slidy was installed.

```bash
 slidy --version
```

# Slidy pipeline


Organize scripts to be executed by automating processes. All steps can be
configured in a file called `slidy.yaml`.
```
slidy run cleanup
```

**slidy.yaml**:
```yaml 
slidy: '1'
variables:
  customMessage: "Complete"    # Gets  ${Local.var.customMessage}

scripts:
  # Simple command (slidy run doctor)
  doctor: flutter doctor

  # Descritive command (slidy run clean)
  clean:
    name: "Clean"
    description: 'minha descricao'
    run: flutter clean

  # Steped command (slidy run cleanup)   
  cleanup:
    description: "cleanup project"
    steps:
      - name: "Clean"
        run: flutter clean
        
      - name: "GetPackages"
        description: "Get packages"
        run: flutter pub get

      - name: "PodClean"
        description: "Execute pod clean"
        shell: bash   # default: command. options (command|bash|sh|zsh|pwsh)
        condition: "${System.operatingSystem} == macos"
        working-directory: ios
        run: |-
          rm Podfile.lock
          pod deintegrate
          pod update
          pod install

      - run: echo ${Local.var.customMessage} 
```

## Propeties

| Propetie    |      Type        |  Doc |
|:----------  |:-----------------|:------|
| slidy       | string         | Slidy pipeline version |
| variables   | object         | Local variables. ex:<br>${Local.var.[VariableName]} |
| scripts     | object         | Add runnable scripts by name |

## Script Propetie

Add custom scripts. <br>
The property name can be invoked using the `slidy run` command.

**Simple example:**

```yaml
...
scripts:
  runner: flutter pub run build_runner build --delete-conflicting-outputs
...
```
Execute this script using ``slidy run runner`

**Complete example:**

```yaml
...
scripts:
  runner: 
    name: "Runner"
    description: "Execute build_runner"
    run: flutter pub run build_runner build --delete-conflicting-outputs
...
```

| Propetie                 |      Type        |  Doc |
|:----------               |:-----------------|:------|
| run                      | string           | script to run |
| name                     | string           | Script name |
| description              | string           | Script description |
| shell                    | string           | options: <br>- command(default)<br>- bash<br>- sh<br>- zsh<br>- pwsh) |
| working-directory        | string           | Run folder  |
| environment              | object           | Add environment variable.|
| steps                    | array(Step)      | Run multiple scripts in sequence..|

**NOTE**: The STEPS or RUN property must be used. It is not allowed to use both at the same time.


**Stepped example:**

```yaml
scripts:
  cleanup:
    description: "cleanup project"
    steps:
      - name: "Clean"
        run: flutter clean
        
      - name: "GetPackages"
        description: "Get packages"
        run: flutter pub get

      - name: "PodClean"
        description: "Execute pod clean"
        shell: bash 
        condition: "${System.operatingSystem} == macos"
        working-directory: ios
        run: |-
          rm Podfile.lock
          pod deintegrate
          pod update
          pod install

      - run: echo ${Local.var.customMessage} 
```

| Step Propetie                 |      Type        |  Doc |
|:----------               |:-----------------|:------|
| run                      | string           | script to run |
| name                     | string           | Script name |
| description              | string           | Script description |
| shell                    | string           | options: <br>- command(default)<br>- bash<br>- sh<br>- zsh<br>- pwsh) |
| working-directory        | string           | Run folder  |
| environment              | object           | Add environment variable.|
| condition                | boolean      |If true, execute this script. |

**NOTE**: The main file is called `slidy.yaml`, but if you want to call other files, use the **--schema** flag of the run command. <br>`slidy run command --schema other.yaml`


# Package manager
Install, Uninstall and find package by command line.
```bash
# install package
slidy install bloc

# install package with version
slidy install flutter_modular@4.0.1

# install package in dev_dependencies
slidy install mocktail --dev

# find package by query
slidy find "Shared preferences"

# show package versions
slidy versions dio
```

# Template generator
Slidy's goal is to help you structure your project in a standardized way. Organizing your app in **Modules** formed by pages, repositories, widgets, BloCs, and also create unit tests automatically. The Module gives you a easier way to inject dependencies and blocs, including automatic dispose. Also helps you installing the dependencies and packages, updating and removing them. The best is that you can do all of this running a single command.

We realized that the project pattern absence is affecting the productivity of most developers, so we're proposing a development pattern along with a tool that imitates NPM (NodeJS) functionality as well as template generation capabilities (similar to Scaffold).


## About the Proposed Pattern

The structure that slidy offers you, it's similar to MVC, where a page keeps it's own **business logic classes(BloC)**.

We recommend you to use [flutter_modular](https://pub.dev/packages/flutter_modular) when structuring with slidy. It offers you the **module structure**(extending the WidgetModule) and dependency/bloc injection, or you will probably get an error.

To understand **flutter_modular**, take a look at the [README](https://github.com/Flutterando/modular/blob/master/README.md).

We also use the **Repository Pattern**, so the folder structure it's organized in **local modules** and a **global module**. The dependencies(repositories, BloCs, models, etc) can be accessed throughout the application.

Sample folder structure generated by **slidy**:


## Commands

**start:**
Create a basic structure for your project (confirm that you have no data in the "lib" folder).

```
slidy start
```

## Generate

Create a module, page, widget or repository according to the option.<br>
Slidy generator supports mobx, bloc, cubit, rx_notifier and triple.

**Options:**

Creates a new module with **slidy generate module**:

```
slidy generate module manager/product
```

Creates a new page with **slidy generate page**:

```
slidy generate page manager/product/pages/add_product
```

Creates a new widget with **slidy generate widget**:

```
slidy generate widget manager/product/widgets/product_detail
```

Create a new repository with **slidy generate repository**

```
slidy g r manager/product/repositories/product
```

Create a new rx notifier with **slidy generate rx**

```
slidy g rx manager/product/page/my_rx_notifier
```

Create a new triple with **slidy generate t**

```
slidy g t manager/product/page/my_triple
```

Create a new cubit with **slidy generate c**

```
slidy g c manager/product/page/my_cubit
```

Create a new mobx with **slidy generate mbx**

```
slidy g mbx manager/product/page/my_store
```

For more details [Telegram Group Flutterando](https://t.me/flutterando)
