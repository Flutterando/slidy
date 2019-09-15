# Setting ".bash_profile" to slidy
The user opens the file ".bash_profile" in the user's root directory.

```
> vi .bash_profile
```
After, access the file just copy and place the lines below, remembering to adjust the installation location of Flutter.

# Setting PATH for Flutter

```
FLUTTER_PATH=/Applications/flutter
BIN=$FLUTTER_PATH/bin
PUB_CACHE_BIN=$FLUTTER_PATH/.pub-cache/bin
DART_PATH=$FLUTTER_PATH/bin/cache/dart-sdk/bin

export PATH=$PATH:$FLUTTER_PATH:$BIN:$PUB_CACHE_BIN:$DART_PATH
```
