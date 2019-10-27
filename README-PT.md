![Pub](https://img.shields.io/pub/v/slidy?color=orange)
[![GitHub stars](https://img.shields.io/github/stars/Flutterando/slidy?color=yellow)](https://github.com/Flutterando/slidy/stargazers)
![Telegram](https://img.shields.io/badge/telegram-flutterando-blue)

[View the docs in English](README.md)

# Slidy
Um gerenciador de pacotes CLI e gerador de templates para Flutter. Gere Módulos, Páginas, Widgets, BLoCs e testes.

# Por que usar?

O objetivo do Slidy é ajudá-lo a estruturar seu projeto de maneira padronizada. Organize seu aplicativo em **Módulos** formados por páginas, repositórios, widgets, BloCs e também crie testes de unidade automaticamente. O módulo oferece uma maneira mais fácil de injetar dependências e blocos, incluindo descarte automático. Também ajuda a instalar as dependências e pacotes, atualizando e removendo-os. O melhor é que você pode fazer tudo isso executando um único comando.

# Motivações

Percebemos que a ausência de padrão de projeto está afetando a produtividade da maioria dos desenvolvedores, por isso propomos um padrão de desenvolvimento junto com uma ferramenta que imita a funcionalidade NPM (NodeJS), bem como os recursos de geração de modelo (semelhante ao Scaffold).

# Sobre o padrão proposto

A estrutura que o slidy oferece a você é semelhante ao MVC, onde uma página mantém suas próprias **business logic classes(BloC)**.

Recomendamos que você use [bloc_pattern](https://pub.dev/packages/bloc_pattern) ao estruturar com slidy. Ele oferece a **estrutura do módulo** (estendendo o ModuleWidget) e a injeção de dependência / bloco, ou você provavelmente receberá um erro.

Para entender o **pacote bloc_pattern**, consulte o [README](https://github.com/jacobaraujo7/bloc-pattern/blob/master/README.md).

Também usamos o **Repository Pattern**, para que a estrutura da pasta seja organizada em **módulos locais** e um **módulo global**. As dependências (repositórios, BloCs, modelos, etc.) podem ser acessadas em todo o aplicativo.

Estrutura de pasta de exemplo gerada por ** slidy **:

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/folderw.png?raw=true)

## Instalação


1. Ative o slidy usando o pub:
    ```
    flutter pub global activate slidy
    ```
2. Digite `slidy --version` para certificar que tudo funcionou corretamente. Este comando deve retornar a versão instalada.


## Comandos:

### upgrade:

Atualiza a versão do slidy:

```
slidy upgrade
```

### start:

Crie a estrutura básica do seu projeto (verifique se a pasta "lib" está vazia).

```  
slidy start
```

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/start_cmd.png)


### run:

Executa os scripts em pubspec.yaml:

```
slidy run open_folder
```

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/scripts.png?raw=true)

### install:

**Instala ou atualiza os pacotes em dependências:**

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/dependencies.png?raw=true)

```
install slidy rxdart dio bloc_pattern
```

ou você pode simplesmente usar o comando **i** (ambos são iguais)

```
slidy i rxdart dio bloc_pattern
```

**Instale pacotes como dev_dependency:**

```
slidy i flutter_launcher_icons --dev
```

![Exemplo de pasta](/dev_d.png)

### uninstall:

Remove um pacote
```
 slidy uninstall dio
```
Você também pode remover uma **dev_dependency** usando o sinalizador --dev


### generate:

Cria um módulo, página, widget ou repositório, incluindo sua classe BloC.

**NOTA:** Você pode substituir "g" pelo comando "generate".

Cria um novo **module**:

```
slidy module g nome_da_pasta
```

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/module_cmd.png?raw=true)

Cria uma nova **página** + BloC:

```
slidy g page nome_da_pasta / páginas
```

Cria um novo **widget** + BloC:

```
slidy g widget nome_da_pasta / widgets
```

**NOTA:** Você pode criar uma página ou widget usando seu respectivo BLoC usando a bandeira **- b**

Crie um novo **repositório**

```
slidy g r nome_da_pasta/repositórios
```

Você também pode usar o "repositório" no lugar de "r", mas ele terá a mesma função.

![Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/screenshots/structure.png?raw=true)

#### Testes de unidade:

Gere **testes de unidade** na pasta de teste para você.

```
slidy test nome_da_pasta/
```

## Erros comuns:

**Windows:** 

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/error_windows_install.jpg?raw=true)

Se você recebeu este erro ao tentar executar o ```pub global enable slidy```, precisará definir as variáveis de ambiente manualmente:

Na pesquisa do Windows, escreva: ```Editar variáveis do sistema```

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/step1.png?raw=true)

Em seguida, clique em ```'Variáveis de ambiente```

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/step2.png?raw=true)

Vá para ```Path```

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/step3.png?raw=true)

Em seguida, clique em Novo e adicione o caminho que apareceu no seu console.

![Folder example](https://github.com/Flutterando/slidy/blob/master/screenshots/step4.png?raw=true)

Para mais informações, assista a [esse](https://www.youtube.com/watch?v=bEroNNzqlF4) vídeo.

Participe do nosso [Grupo da Flutterando no Telegram!](https://t.me/flutterando)
