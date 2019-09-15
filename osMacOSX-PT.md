
# Configurando o ".bash_profile" para  slidy
O usuário abre o aquivo ".bash_profile" no diretorio raiz do usuário.


```
 vi .bash_profile
```

Após, acessar o arquivo apenas copiar e colocar as linhas abaixo, lembrando de ajustar o local de instalação do Flutter.


# Configurando PATH para Flutter

```
FLUTTER_PATH=/Applications/flutter
BIN=$FLUTTER_PATH/bin
PUB_CACHE_BIN=$FLUTTER_PATH/.pub-cache/bin
DART_PATH=$FLUTTER_PATH/bin/cache/dart-sdk/bin

export PATH=$PATH:$FLUTTER_PATH:$PUB_CACHE_BIN:$DART_PATH
```