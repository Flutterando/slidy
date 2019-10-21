<<<<<<< HEAD
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

![Exemplo de pasta](/start_cmd.png)


### run:

Executa os scripts em pubspect.yaml:

```
slidy run open_folder
```

! [Exemplo de pasta](https://github.com/Flutterando/slidy/blob/master/scripts.png?raw=true)

### install:

**Instala ou atualiza os pacotes em dependências:**

! [Exemplo de pasta](/dependencies.png)

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
 slidy desinstalar dio
```
Você também pode remover uma **dev_dependency** usando o sinalizador --dev


### generate:

Cria um módulo, página, widget ou repositório, incluindo sua classe BloC.

**NOTA:** Você pode substituir "g" pelo comando "generate".

Cria um novo **module**:

```
slidy module g folder_name
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

  ![Folder example](/step1.png)

  Em seguida, clique em ```'Variáveis ​​de ambiente```

  ![Folder example](/step2.png)

  Vá para ```Path```

  ![Folder example](/step3.png)

  Em seguida, clique em Novo e adicione o caminho que apareceu no seu console.

  ![Folder example](/step4.png)

  Para mais informações, assista a [esse](https://t.me/flutterando) vídeo.



Participe do nosso [Grupo da Flutterando no Telegram!](https://t.me/flutterando)
=======
[Click here to see in english](README.md)
# Slidy

Esse CLI consiste em uma forma de mostrar o seu projeto estruturado por módulos, páginas, repositórios e widgets, sempre seguindo os padrões de boas práticas que vem sendo aplicado pela comunidade flutter em projetos maiores e mais estruturados. 
Ele também fornece o gerenciador de bibliotecas (libs ou pubs) com ele você pode instalar varias bibliotecas com apenas uma linha de comando e até mesmo remover e atualizar.

## IMPORTANTE! Package ainda em desenvolvimento.

Estamos empolgados em entregar o slidy para a comunidade, porém ainda é um package que está em desenvolvimento e pode apresentar alguns comportamento estranhos. Use com cautela.
Para agilizar e ajudar no desenvolvimento, coopere colocando seus problemas e sugestões na tab de **issues** desse repositório.

## Motivação

Percebemos que a falta de um padrão de projetos está afetando a produtividade de vários desenvolvedores nesse momento inicial, então estamos propondo um padrão de desenvolvimento junto com uma ferramenta que imita funcionalidades do NPM (NodeJS) e também recursos para geração de templates (Semelhante ao Scaffold).

## Sobre o Padrão Proposto.

Adotamos o padrão BLoC para regra de negócio em uma estrutura similar ao  MVC, onde uma página ou widget tem um ou mais BLoC para gerenciar sua regra de negócio.

Estamos usando a estrutura de módulos e injeção de dependências do package [bloc_pattern](https://pub.dev/packages/bloc_pattern). Leia o [README](https://github.com/jacobaraujo7/bloc-pattern/blob/master/README.md) do bloc_pattern para se familiarizar com o conceito de injeção de dependência, BLoC Provider e módulos.

Para serviços e provider aplicamos o **Repository Pattern**.

Com isso nossa estrutura de pastas fica organizada em módulos locais e um módulo global, bem como modelos, repositories e BLoC`s que podem ser acessados em toda a aplicação disposta na pasta shared.

Exemplo de estrutura de pastas gerada pelo **Slidy**:

![Folder example](https://github.com/Flutterando/slidy/blob/master/folderw.png?raw=true)

## Instalação

- Você precisar ter instalado o SDK do Dart. Se não tem [baixe agora](https://dart.dev/get-dart).
- Será necessario reiniciar a maquina para o SDK do Dart funcionar.
- Agora basta ativar o slidy usando o pub:
 0bs. Em algumas maquinas será necessario colocar o "caminho" do slidy no path. 

```
pub global activate slidy
```
- Digite ` slidy --version` - se retornar a versão do slidy pode considerar a instalação completa.
- Para atualizar o slidy basta usar o comando:
```
slidy upgrade
```

Pronto a partir de agora você ja pode desfrutar desse novo mundo.

## Comandos:    
  **start:** 
     Cria uma estrutura básica para seu projeto ( confirme que você não tenha nenhum dado na pasta "lib").
```  
slidy start
```     

**Install:**
Instala (ou atualiza) um novo pacote (package) ou pacotes:
```
slidy install rxdart dio bloc_pattern
```
Você também pode instalar um pacote como dev_dependency usando a flag --dev
```
slidy i flutter_launcher_icons --dev
``` 
Remove um pacote:
 ```
 slidy uninstall dio 
 ```
Você também pode remover um dev_dependency usando a flag --dev

## Generate:

Cria um modulo, pagina, widget or repositório conforme a opção.
    
**Opções:**
    
Cria um novo modulo com o **slidy generate module**:
``` 
slidy generate module manager/product/product
``` 

Cria uma nova pagina e o seu respectivo Bloc:
```
slidy generate page manager/product/pages/add_product
``` 
            
Cria uma novo widget e o seu respectivo Bloc:
```
slidy generate widget manager/product/widgets/product_detail
``` 
OBS: Você pode criar uma page ou widget com seu respectivo BLoC usando a flag **-b**
            
Cria uma novo repositório:
```
slidy g r manager/product/repositories/product
``` 
    
## Erros Comuns:

**Windows:** 

  ![Folder example](/error_windows_install.jpg)

  Caso vocês se depare com o erro acima ao tentar rodar o comando ```pub global activate slidy```, entao vai ter que colocar nas variáveis de ambiente manualmente:

  Va na pesquisa do windows e procure por :  ```Editar as variáveis de ambiente```

  Depois click em ```Variáveis de Ambiente```

  Procure por ```Path``` e de dois clicks

  Então click em Novo e adicione o caminho que apareceu no seu console no caso aqui é : ```C:\Users\1513 MX5-7\AppData\Roaming\Pub\Cache\Bin``` depois disso só reiniciar seu CMD.




Para mais detalhes: https://t.me/flutterando
>>>>>>> 2f431f953aed90d425f32232a3317fd7f82f3bb4
