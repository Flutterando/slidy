[Click here to see in english](README.md)
# Slidy

Esse CLI consiste em uma forma monstar o seu projeto estruturado por modulos, paginas, repositorios, widgets sempre seguindo os padrões de boas praticas quem vem sendo aplicado pela comunidade flutter em projetos maiores e mais estruturados. 
Ele também fornece o gerenciador de bibliotecas (libs ou pubs) com ele você pode instalar varias bibliotecas com apenas uma linha de comando e até mesmo remover e atualizar.

## IMPORTANTE! Package ainda em desenvolvimento.

Estamos empolgados em entregar o slidy para a comunidade, porém ainda é um package que está em desenvolvimento e pode apresentar alguns comportamento estranhos. Use com cautela.
Para agilizar e ajudar no desenvolvimento, coopere colocando seus problemas e sugestões na tab de **issues** desse repositório.

## Motivação

Percebemos que a falta de um padrão de projetos está afetando a produtividade de varios desenvolvedores nesse momento inicial, então estamos proponto um padrão de desenvolvimento junto com uma ferramente que imita funcionalidades do NPM (NodeJS) e também recursos para geração de templates (Semelhante ao Scaffold).

## Sobre o Padrão Proposto.

Adotamos o padrão BLoC para regra de negócio em uma estrutura similar ao  MVC, onde uma página ou widget tem um ou mais BLoC para gerenciar sua regra de negócio.

Estamos usando a estrutura de módulos e injeção de dependências do package [bloc_pattern]('https://pub.dev/packages/bloc_pattern'). Leia o README do bloc_pattern para se familiarizar com o conceito de injeção de dependência, BLoC Provider e módulos.

Para serviços e provider aplicamos o **Repository Pattern**.

Com isso nossa estrutura de pastas fica organizada em módulos locais e um módulo global, bem como modelos, repositories e BLoC`s que podem ser acessados em toda a aplicação dispostos na pasta shared.

Exemplo de estrutura de pastas gerada pelo **slidy**:

![Folder example](/folder.png)

## Instalação

- Você precisar ter instalado o SDK do Dart. Se não tem [baixe agora](https://dart.dev/get-dart).
- Agora basta ativar o slidy usando o pub:

```
pub global activate slidy
```
- Digite ` slidy --version` - se retornar a versão do slidy pode considerar a instalação completa.
- Para atualizar o slidy basta usar o comando:
```
slidy upgrade
```

Pronto a partir de agora você ja pode disfrutar desse novo mundo.

## Comandos:    
  **start:** 
     Cria uma estrutura básica para seu projeto ( confirme que você não tenha nenhum dado na pasta "lib").
```  
slidy start
```     

**Install:**
Instala (ou atualiza) um novo pacote(package) ou pacotes:
```
slidy install rxdart dio bloc_pattern
```
Você também pode instalar um pacote como dev_dependency usando a flag --dev
```
slidy i flutter_launcher_icons --dev
``` 
remove um pacote
 ```
 slidy uninstall dio 
 ```
Você também pode remover um dev_dependency usando a flag --dev


## Generate:

Cria um modulo, pagina, widget or repositorio conforme a opção.
    
**Opções:**
    
Cria um novo modulo com o **slidy generate module**:
``` 
slidy generate module manager/product/product
``` 

Cria uma nova pagina e o seu respectivo Bloc
```
slidy generate page manager/product/pages/add_product
``` 
            
Cria uma novo widget e o seu respectivo Bloc:
```
slidy generate widget manager/product/widgets/product_detail
``` 
OBS: Você pode criar uma page ou widget sem o BLoC usando a flag **-b**
            
Cria uma novo repositorio
```
slidy g r manager/product/repositories/product
``` 
    

Para mais detalhes https://t.me/flutterando
