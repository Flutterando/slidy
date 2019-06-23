[Para ver em Português clique aqui](README-PT.md)

# Slidy

&nbsp;&nbsp;&nbsp;&nbsp;This project is a CLI (command-line interface) for Flutter.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;This CLI consists of a way to assemble your project structured by modules, pages, repositories, widgets always following the standards of good practices that has been applied by the community flutter in bigger and more structured projects.<br/>
&nbsp;&nbsp;&nbsp;&nbsp;It also provides the library manager (libs or pubs) with it you can install a library, install multiple libraries with just one command line and even remove and update and all of this in a simple way.<br/>

## Getting Started <br>

To start you need just install the Slidy:<br/>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;`pub global activate slidy`

<br>Ready now you can enjoy this new world.<br/>

#### Comands:     <br>
  **start:** <br>
     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Create a basic structure for your project ( make sure you have any data on "Lib" folder)*<br/>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy start `

**Install:**<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**install[i] [package name] [package name] [..]** 	<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Install a new package or packages*<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy i rxdart dio bloc_pattern `

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**install[i] [package name] [package name] [..] --dev** <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Install a dev dependency package or packages*<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy i flutter_launcher_icons --dev ` 


&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**uninstall [package name]**	<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Remove a package*<br/>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy uninstall dio` 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**uninstall [package name] --dev**	<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Remove a dev_dependency package*<br/>
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy uninstall flutter_launcher_icons --dev  ` 

**Generate:** <br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**generate[g]**<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *Creates a module, page, widget or repository according to the option.*<br/>
    
&nbsp;&nbsp;&nbsp;&nbsp;**Options:** <br>
    
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**module[m] [module_name]** <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Creates a new module*<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g m manager/product/product` 
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**page[p] [module_name(optional)]/[pages(optional)]/[page_name]**	<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Creates a new page with your respective Bloc*<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;             ` slidy g p manager/product/pages/add_product	` 
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**widget[w] [module_name(optional)]/[widgets(optional)]/[widget_name]** <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Creates a new widget with your respective Bloc*<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g w manager/product/widgets/product_detail` 
            
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**repository[r] [module_name(optional)]/[repositories(optional)]/[repository_name]** <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*Creates a new repository*<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g r manager/product/repositories/product` 
    

&nbsp;&nbsp;&nbsp;&nbsp;**Optional parameters:** <br>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**b**  <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*this parameter prevent a creation of a useless "Bloc"*<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g w product/widgets/product_buttom b` <br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;or<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy g p home/start/pages/product_detail b` <br/>

**Ajuda**<br/>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**--ajuda**<br/>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;` slidy ajuda ` <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Mostra a Ajuda em português <br/><br/><br/>

For more details https://t.me/flutterando
