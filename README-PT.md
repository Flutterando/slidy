![Pub](https://img.shields.io/pub/v/slidy?color=orange)
[![GitHub stars](https://img.shields.io/github/stars/Flutterando/slidy?color=yellow)](https://github.com/Flutterando/slidy/stargazers)
[![Telegram](https://img.shields.io/badge/telegram-flutterando-blue)](https://t.me/flutterando)

[![Actions Status](https://github.com/AlvaroVasconcelos/slidy/workflows/Dart%20CI/badge.svg)](https://github.com/AlvaroVasconcelos/slidy/workflows/actions)
[![Actions Status](https://github.com/AlvaroVasconcelos/slidy/workflows/Example%20Android/badge.svg)](https://github.com/AlvaroVasconcelos/slidy/workflows/actions)
[![Actions Status](https://github.com/AlvaroVasconcelos/slidy/workflows/Example%20iOS/badge.svg)](https://github.com/AlvaroVasconcelos/slidy/workflows/actions)
[![Actions Status](https://github.com/AlvaroVasconcelos/slidy/workflows/Packages/badge.svg)](https://github.com/AlvaroVasconcelos/slidy/workflows/actions)
[![Actions Status](https://github.com/AlvaroVasconcelos/slidy/workflows/Tests/badge.svg)](https://github.com/AlvaroVasconcelos/slidy/workflows/actions)

[View the docs in English](README.md)

# Slidy

Um gerenciador de pacotes CLI e gerador de templates para Flutter. Gere Módulos, Páginas, Widgets, BLoCs, Controles e testes.
O Slidy suporta os principais gerenciadores de estado, rxBLoC, flutter_bloc e mobx.

# Por que usar?

O objetivo do Slidy é ajudá-lo a estruturar seu projeto de maneira padronizada. Organize seu aplicativo em **Módulos** formados por páginas, repositórios, widgets, BloCs e também crie testes de unidade automaticamente. O módulo oferece uma maneira mais fácil de injetar dependências e blocos, incluindo descarte automático. Também ajuda a instalar as dependências e pacotes, atualizando e removendo-os. O melhor é que você pode fazer tudo isso executando um único comando.

# Motivações

Percebemos que a ausência de padrão de projeto está afetando a produtividade da maioria dos desenvolvedores, por isso propomos um padrão de desenvolvimento junto com uma ferramenta que imita a funcionalidade NPM (NodeJS), bem como os recursos de geração de modelo (semelhante ao Scaffold).

# Sobre o padrão proposto

A estrutura que o slidy oferece a você é semelhante ao MVC, onde uma página mantém suas próprias **business logic classes(BloC)**.

Recomendamos que você use [flutter_modular](https://pub.dev/packages/flutter_modular) ao estruturar com slidy. Ele oferece a **estrutura do módulo** (estendendo o WidgetModule) e a injeção de dependência / bloc, ou você provavelmente receberá um erro.

Para entender o **flutter_modular**, consulte o [README](https://github.com/Flutterando/modular/blob/master/README.md).

Também usamos o **Repository Pattern**, para que a estrutura da pasta seja organizada em **módulos locais** e um **módulo global**. As dependências (repositórios, BloCs, modelos, etc.) podem ser acessadas em todo o aplicativo.

Estrutura de pasta de exemplo gerada por **slidy**:

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/folderw.png?raw=true)

## Instalação

1. Primeiramente você precisa instalar o Dart versão 2.9.2
   1. Sistema operacional windows:
      1. Realizar o download da versão 2.9.2 em https://dart.dev/tools/sdk/archive
      2. Extrair o zip em algum diretório
      3. Adicionar o diretório/bin no path antes da entrada do flutter.
      4. Reiniciar o prompt para que busque os novos caminhos.
   2. Para outros sistemas operacionais acesse[https://dart.dev/get-dart](https://dart.dev/get-dart) e siga as instruções de como instalar):

2. Ative o slidy usando o pub:

```bash
flutter pub global activate slidy
```

3. Digite `slidy --version` para certificar que tudo funcionou corretamente. Este comando deve retornar a versão instalada.

## Comandos:

### upgrade:

Atualiza a versão do slidy.

```bash
slidy upgrade
```

### create:

Cria um novo projeto na mesma estrutura descrita no comando start.

```bash
slidy create **meuprojeto**
```

### start:

Cria a estrutura básica de um projeto existente.\
verifique se a pasta _lib/_ está vazia, pois o slidy apagará a pasta após confimação, recriando em seguida.

```bash
slidy start
```

Escolha seu provedor:

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/choose_provider.PNG?raw=true)

Agora escolha seu Gerenciador de Estados:

Mobx

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/choose_state_management_mobx.PNG?raw=true)

E você vai ter essa estrutura:

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/start_cmd.png?raw=true)

Flutter Bloc:

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/choose_state_management_flutter_bloc.PNG?raw=true)

E você vai ter essa estrutura:

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/start_cmd_flutter_bloc.PNG?raw=true)

Bloc With RxDart

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/choose_state_management_rxdart.PNG?raw=true)

E você vai ter essa estrutura:

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/start_cmd_rxdart.PNG?raw=true)

Se você tiver o pacote `flutter_bloc` ou `flutter_mobx` no pubspec, a geração de páginas, widgets e blocs será padronizada para o padrão do gerenciador instalado.

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/start_cmd.png?raw=true)

#### Opções

O comando permite especificar o provedor e o gerenciador de estados utilizando as seguintes opções:

- Provedor:

```bash
-p <nome_do_provedor>

Opções:
flutter_modular / bloc_pattern

Exemplo:
slidy start -p flutter_modular
```

- Gerenciador de estado:

```bash
-s <gerenciador_de_estado>

Opções:
mobx / flutter_bloc / rxdart
Exemplo:
slidy start -s mobx
```

- Provedor e gerenciador de estado:

```bash
slidy start -p flutter_modular -s mobx
```

O comando avisa que irá apagar a pasta _lib/_ e pede a confimação. Caso não queira ver esse aviso, adicione a flag -e (do inglês "erase", apagar):

```bash
slidy start -p flutter_modular -s mobx -e
```

### run:

Executa os scripts em pubspec.yaml:

```bash
slidy run open_folder
```

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/scripts.png?raw=true)


Você pode adicionar uma sessão var para customizar seus scripots
```
vars:
  runner: flutter pub run build_runner
  clean: flutter clean
  get: flutter pub get
scripts:
    mobx_build: $clean & $get & $runner build --delete-conflicting-outputs
    mobx_watch: $clean & $get & $runner watch --delete-conflicting-outputs
```

```bash
slidy run mobx_build
```

### install:

**Instala ou atualiza os pacotes em dependências:**

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/dependencies.png?raw=true)

```bash
slidy install rxdart dio bloc_pattern
```

ou você pode simplesmente usar o comando **i** (ambos são iguais)

```bash
slidy i rxdart dio bloc_pattern
```

**Instale pacotes como dev_dependency:**

```bash
slidy i mockito --dev
```

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/dev_d.png?raw=true)

### uninstall:

Remove um pacote

```bash
 slidy uninstall dio
```

Você também pode remover uma **dev_dependency** usando o sinalizador --dev

### update:

Atualiza depedencias para a ultima versao:
Você pode atualizar apenas uma depedencia
```bash
slidy update mobx
```

Ou atualizar todas as depedencias usando o sinalizador --all ou -a
```bash
slidy update -a
```

Você também pode atualizar uma ou todas **dev_dependencies** usando o sinalizador --dev

### generate:

Cria um módulo, página, widget ou repositório, incluindo sua classe BloC.

**NOTA:** Você pode substituir "g" pelo comando "generate".

Cria um novo **module**:

```bash
slidy g module nome_da_pasta
```

ou

```bash
slidy g m nome_da_pasta
```

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/module_cmd.png?raw=true)

**NOTE:** Você pode criar um "Modulo Completo" com Module, Page, Bloc/Controller, testes para Page e para Bloc/Controller usando a flag **-c**


**NOTE² :** Você pode criar um "Repository" com seu Module usando a flag **-r**

```` slidy g m modules/my_module -c -r ````

**NOTE³ :** Você pode criar uma "Interface" para seu repositório with your Module usando a flag flag **-i**

```` slidy g m modules/my_module -c -r -i ````



Cria uma nova **página** + BloC:

```bash
slidy g page nome_da_pasta/páginas
```

ou

```bash
slidy g p nome_da_pasta/páginas
```

Cria um novo **widget** + BloC:

```bash
slidy g widget nome_da_pasta/widgets
```

ou

```bash
slidy g w nome_da_pasta/widgets
```

**NOTA:** Você pode criar uma página ou widget usando seu respectivo BLoC usando a bandeira **- b**

Crie um novo **repositório**

```bash
slidy g r nome_da_pasta/repositórios
```

**NOTE :** você pode criar uma "Interface" para seu repositorio usando a flag **-i**

```` slidy g m modules/my_module -c -r -i ````

Você também pode usar o "repositório" no lugar de "r", mas ele terá a mesma função.

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/structure.png?raw=true)

Crie um novo **serviço**

```bash
slidy g s folder_name/servicos
```
**NOTE :** você pode criar uma "Interface" para seu serviço usando a flag **-i**

```` slidy g m modules/my_module -c -s -i ````

Crie um novo **modelo**

```bash
slidy g mm nome_da_pasta/modelo
```

**NOTE :** Se você estiver utilizando o JsonSerializable (e 'json_annotation' estiver Dependecy e o 'json_serializable' estiver no dev_dependencies) esse comando ira cria com as Anotations



#### Testes de unidade:

Gere **testes de unidade** na pasta de teste para você.

```bash
slidy test nome_da_pasta/
```

## Automação de Tradução - Localização
O comando `slidy localization` ajuda na utilização do [package localization](https://pub.dev/packages/localization).

Esse comando captura todos os `.i18n()` no código e os comentários em sua frente. Se essa chave já existir, atualiza seu valor em todos os arquivos de localização, se não, inclui a chave e seu valor no final de todos os arquivos de localização.

Em ambas situações, o comentário é removido para manter o código limpo.

O diretório de localização deve ser definido na raíz do arquivo `pubspec.yaml`, dessa forma:
```
localization_dir: assets\language
```
**NOTE :** É recomendado definir o diretório no final do arquivo.

### Exemplo

<details>
<summary><b>Antes do comando</b></summary><br/>

**pt_BR.json**
```json
{
  "login-label": "Usuário"
}
```

**login_page.dart**
```dart
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: "user-label".i18n())),
          TextField(decoration: InputDecoration(labelText: "password-label".i18n())), //Senha
        ],
      ),
    );
  }
}
```

</details>

<details>
<summary><b>Após o comando</b></summary><br/>

**pt_BR.json**
```json
{
  "login-label": "Usuário",
  "password-label": "Senha"
}
```

**login_page.dart**
```dart
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(labelText: "user-label".i18n())),
          TextField(decoration: InputDecoration(labelText: "password-label".i18n())),
        ],
      ),
    );
  }
}
```
</details>

## Erros comuns:

**Não consegue atualizar:**
1 - Primeiro desinstalar o Slidy no Flutter

```
flutter pub global deactivate slidy
```

2 - Depois desinstalar o Slidy no Dart

```
pub global deactivate slidy
```

2 - E instalar apenas no Dart

```
pub global activate slidy
```

3 - Caso você não tenha o Pub você vai precisar instalar o Dart:

[https://dart.dev/get-dart](https://dart.dev/get-dart)

**Windows:**

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/error_windows_install.jpg?raw=true)

Se você recebeu este erro ao tentar executar o `pub global enable slidy`, precisará definir as variáveis de ambiente manualmente:

Na pesquisa do Windows, escreva: `Editar variáveis do sistema`

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/step1.png?raw=true)

Em seguida, clique em `Variáveis de ambiente`

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/step2.png?raw=true)

Vá para `Path`

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/step3.png?raw=true)

Em seguida, clique em Novo e adicione o caminho que apareceu no seu console.

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/step4.png?raw=true)

Para mais informações, assista a [esse](https://www.youtube.com/watch?v=bEroNNzqlF4) vídeo.

Participe do nosso [Grupo da Flutterando no Telegram!](https://t.me/flutterando)
