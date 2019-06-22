String startHelpEn = '''
Usage: slidy [options]
Options:
	Start:
		start Create a basic structure for your project ( make sure you have any data on "Lib" folder)
			Ex.: slidy start 
	Install:
		install[i] [package name][package name][..] 	Install a new package or packages	
			Ex.: slidy i rxdart dio bloc_pattern
		install[i] [package name][package name][..] --dev	Install a dev dependency package or packages
			Ex.: slidy i flutter_launcher_icons --dev
		uninstall [package name]	Remove a package
			Ex.: slidy uninstall dio
		uninstall [package name]	Remove a dev_dependency package
			Ex.: slidy uninstall flutter_launcher_icons --dev  

	Generate:
		generate[g] Creates a module, page, widget or repository according to the option.
		Options:
			module[m] [module_name] Creates a new module
				Ex.: slidy g m manager/product/product
			page[p] [module_name(optional)]/[pages(optional)]/[page_name]	Creates a new page with your respective Bloc	
				Ex.: slidy g p manager/product/pages/add_product	
			widget[w] [module_name(optional)]/[widgets(optional)]/[widget_name] Creates a new widget with your respective Bloc
				Ex.: slidy g w manager/product/widgets/product_detail
			repository[r] [module_name(optional)]/[repositories(optional)]/[repository_name] Creates a new repository
				Ex.: slidy g r manager/product/repositories/product
		
	Optional parameters:
		b this parameter prevent a creation of a useless "Bloc"
			slidy g w product/widgets/product_buttom b
			or
			slidy g p home/start/pages/product_detail b
	
	--ajuda:
		slidy ajuda Mostra a Ajuda em português
		
For more details https://t.me/flutterando
''';

String startHelpPt = '''
Uso: slidy [opções]
Opções:
	Start:
		start Cria uma estrutura basica para seu projeto ( confirme que você não tenha nenhum dado na pasta "Lib")
			Ex.: slidy start 

	Install:
		install[i] [package name][package name][..] 	Instala um novo pacote(package) ou pacotes	
			Ex.: slidy i rxdart dio bloc_pattern
		install[i] [package name][package name][..] --dev Instala um novo pacote(package) ou pacotes como dev dependency
			Ex.: slidy i flutter_launcher_icons --dev
		uninstall [package name]	remove um pacote
			Ex.: slidy uninstall dio
		uninstall [package name]	remove um pacote da dev_dependency
			Ex.: slidy uninstall flutter_launcher_icons --dev  
	
	Generate:
		generate[g] cria um modulo, pagina, widget or repositorio conforme a opção.
		Opções:
			module[m] [module_name] cria um novo modulo
				Ex.: slidy g m manager/product/product		
			page[p] [module_name(optional)]/[pages(optional)]/[page_name]	Cria uma nova pagina e o seu respectivo Bloc	
				Ex.: slidy g p manager/product/pages/add_product	
			widget[w] [module_name(optional)]/[widgets(optional)]/[widget_name] Cria uma novo widget e o seu respectivo Bloc
				Ex.: slidy g w manager/product/widgets/product_detail		
			repository[r] [module_name(optional)]/[repositories(optional)]/[repository_name] Cria uma novo repositorio
				Ex.: slidy g r manager/product/repositories/product
		
	Parametro opcional:
		-b  Esse parametro evita de você criar um "Bloc" sem utilidade
			slidy g w product/widgets/product_buttom b
			or
			slidy g p home/start/pages/product_detail b
	help:
		slidy help Show a english help

Para mais detalhes https://t.me/flutterando
''';