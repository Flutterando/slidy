# Slidy - Por que usar?

O objetivo do Slidy é ajudá-lo a estruturar seu projeto de maneira padronizada. Organize seu aplicativo em **Módulos** formados por páginas, repositórios, widgets, BloCs e também crie testes de unidade automaticamente. O módulo oferece uma maneira mais fácil de injetar dependências e blocos, incluindo descarte automático. Também ajuda a instalar as dependências e pacotes, atualizando e removendo-os. O melhor é que você pode fazer tudo isso executando um único comando.

# Motivações

Percebemos que a ausência de padrão de projeto está afetando a produtividade da maioria dos desenvolvedores, por isso propomos um padrão de desenvolvimento junto com uma ferramenta que imita a funcionalidade NPM (NodeJS), bem como os recursos de geração de modelo (semelhante ao Scaffold).

# Sobre o padrão proposto

A estrutura que o slidy oferece a você é semelhante ao MVC, onde uma página mantém suas próprias **business logic classes(BloC)**.

Recomendamos que você use [bloc_pattern](https://pub.dev/packages/bloc_pattern) ao estruturar com slidy. Ele oferece a **estrutura do módulo** (estendendo o ModuleWidget) e a injeção de dependência / bloco, ou você provavelmente receberá um erro.

Para entender o **pacote bloc_pattern**, consulte o [README](https://github.com/jacobaraujo7/bloc-pattern/blob/master/README.md).

Também usamos o **Repository Pattern**, para que a estrutura da pasta seja organizada em **módulos locais** e um **módulo global**. As dependências (repositórios, BloCs, modelos, etc.) podem ser acessadas em todo o aplicativo.

Estrutura de pasta de exemplo gerada por ** slidy **:

! [Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/folderw.png?raw=true)

## Instalação


1. Você precisa ter o [Dart SDK](https://dart.dev/get-dart) instalado.
2. Ative o slidy usando o pub:
    ```
    pub global activate slidy
    ```
3. Digite `slidy --version` se retornar a versão em que está trabalhando.


## Comandos:

#### upgrade:

Atualiza a versão do slidy:

```
slidy upgrade
```

#### start:

Crie a estrutura básica do seu projeto (verifique se a pasta "lib" está vazia).

```  
slidy start
```

![Exemplo de pasta](/start_cmd.png)


#### run:

Executa os scripts em pubspect.yaml:

```
slidy run open_folder
```

! [Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/scripts.png?raw=true)

#### instalar:

**Instala ou atualiza os pacotes em dependências:**

! [Exemplo de pasta](/dependencies.png)

```
instalação slidy rxdart dio bloc_pattern
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

#### Desinstalar:

Remove um pacote
 ```
 slidy desinstalar dio
```
Você também pode remover uma **dev_dependency** usando o sinalizador --dev


#### gerar:

Cria um módulo, página, widget ou repositório, incluindo sua classe BloC.

**NOTA:** Você pode substituir "g" pelo comando "generate".

Cria um novo **módulo**:

```
slidy módulo g folder_name
```

![Exemplo de pasta](/module_cmd.png)

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
slidy g r nome_da_pasta / repositórios
```

Você também pode usar o "repositório" no lugar de "r", mas ele terá a mesma função.

![Exemplo de pasta](/structure.png)


#### Testes de unidade:

Gere **testes de unidade** na pasta de teste para você.

```
slidy test folder_name 
```

## Erros comuns:

**Windows:** 

  ![Folder example](/error_windows_install.jpg)

  Se você recebeu este erro ao tentar executar o ```pub global enable slidy```, precisará definir as variáveis ​​de ambiente manualmente:

  Na pesquisa do Windows, escreva: ```Editar variáveis ​​do sistema```

  ![Folder example](/step1.jpg)

  Em seguida, clique em ```'Variáveis ​​de ambiente```

  ![Folder example](/step2.jpg)

  Vá para ```Path```

  ![Folder example](/step3.jpg)

  Em seguida, clique em Novo e adicione o caminho que apareceu no seu console.

  ![Folder example](/step4.jpg)

  Para mais informações, assista a [esse](https://t.me/flutterando) vídeo.



Participe do nosso [Grupo da Flutterando no Telegram!](https://t.me/flutterando)