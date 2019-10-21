help() {
  print('''
Usage: slidy [options]
Options:
	
- Start: start Create a basic structure for your project (make sure that you haven't any file in "lib" folder)
e.g.: slidy start 

 - Install package(s): install [package name] [..]	
e.g.: slidy i rxdart dio bloc_pattern

- Install dev package(s): install [package name] [..]
e.g.: slidy i flutter_launcher_icons --dev

- Uninstall package: uninstall [package name] 
e.g.: slidy uninstall dio

Uninstall dev package: uninstall [package name] --dev
e.g.: slidy uninstall flutter_launcher_icons --dev  


- Generate:

Creates a module, page, widget or repository according to the option.
		
Options:

- module [module_name] Creates a new module
Ex.: slidy g m manager/product/product

- page [module_name(optional)]/[pages(optional)]/[page_name]	
Creates a new page with your respective Bloc
Ex.: slidy g p manager/product/pages/add_product	

widget [module_name(optional)]/[widgets(optional)]/[widget_name] 
Creates a new widget with your respective Bloc
Ex.: slidy g w manager/product/widgets/product_detail

repository [module_name(optional)]/[repositories(optional)]/[repository_name] 
Creates a new repository
Ex.: slidy g r manager/product/repositories/product
		
Optional parameters:
	b this parameter prevent a creation of a useless "Bloc"
	slidy g w product/widgets/product_buttom b
	or
	slidy g p home/start/pages/product_detail b
	

For easier your life, can be used:
i for install
g for generate
r for repository
w for widget
p for page
m for module
		
For more details https://t.me/flutterando
''');
}
