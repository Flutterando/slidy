# Slidy

&nbsp;&nbsp;&nbsp;&nbsp;Esse projeto é um CLI (command-line interface) para Flutter.
&nbsp;&nbsp;&nbsp;&nbsp;Esse CLI consiste em uma forma monstar o seu projeto estruturado por modulos, paginas, repositorios, widgets sempre seguindo os padrões de boas praticas quem vem sendo aplicado pela comunidade flutter em projetos maiores e mais estruturados.
&nbsp;&nbsp;&nbsp;&nbsp;Ele também fornece o gerenciador de bibliotecas (libs ou pubs) com ele você pode instalar uma biblioteca, instalar varias bibliotecas com apenas uma linha de comando e até mesmo remover e atualizar e tudo isso de uma forma simples.

## Getting Started

Para começar a usar você precisa instalar o Slidy:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`pub global activate slidy`

Pronto a partir de agora você ja pode disfrutar desse novo mundo.

#### Comands:    
  **start:**   
     
     
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Cria uma estrutura básica para seu projeto ( confirme que você não tenha nenhum dado na pasta "Lib")*
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy start `

**Install:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;install[i] [package name][package name][..] 	*Instala um novo pacote(package) ou pacotes*
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy i rxdart dio bloc_pattern `

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;install[i] [package name][package name][..] --dev *Instala um novo pacote(package) ou pacotes como dev dependency*
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy i flutter_launcher_icons --dev ` 


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uninstall [package name]	remove um pacote
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy uninstall dio` 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;uninstall [package name]	*Remove um pacote da dev_dependency*
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy uninstall flutter_launcher_icons --dev  ` 

**Generate:**
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;generate[g] *Cria um modulo, pagina, widget or repositorio conforme a opção.*
    
&nbsp;&nbsp;&nbsp;&nbsp;**Opções:**
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;module[m] [module_name] *Cria um novo modulo*
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g m manager/product/product` 
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;page[p] [module_name(optional)]/[pages(optional)]/[page_name]	*Cria uma nova pagina e o seu respectivo Bloc*
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;             ` slidy g p manager/product/pages/add_product	` 
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;widget[w] [module_name(optional)]/[widgets(optional)]/[widget_name] *Cria uma novo widget e o seu respectivo Bloc*
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g w manager/product/widgets/product_detail` 
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;repository[r] [module_name(optional)]/[repositories(optional)]/[repository_name] *Cria uma novo repositorio*
             &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g r manager/product/repositories/product` 
    

&nbsp;&nbsp;&nbsp;&nbsp;**Parametro opcional:**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;b  *Esse parametro evita de você criar um "Bloc" sem utilidade*
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g w product/widgets/product_buttom b` 
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ou
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g p home/start/pages/product_detail b` 

**Help**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--help:
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy help Show a english help` 

Para mais detalhes https://t.me/flutterando
