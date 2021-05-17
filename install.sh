#!/usr/bin/env bash
cd $HOME
if [[ -f .temp_slidy_installer ]]
then
  rm -rf .temp_slidy_installer
fi

mkdir $(pwd)/.temp_slidy_installer

cd $(pwd)/.temp_slidy

THEARCH=$(uname -m)
THEBIT=$(getconf LONG_BIT)

if [[ $THEARCH == *$THEBIT* ]]; then

  echo "downloading the lastest slidy' version!"
  THEURL=$(curl -s https://api.github.com/repos/Flutterando/slidy/releases | grep browser_download_url | grep 'linux-x64[.]tar[.]gz' | head -n 1 | cut -d '"' -f 4)
  curl -L $THEURL > slidy_temp.tar.gz

fi

tar -xvzf slidy_temp.tar.gz
sudo cp slidy/slidy /usr/bin/

echo "Cleaning environment ..."
cd $HOME
rm -rf .temp_slidy_installer

slidy -v 