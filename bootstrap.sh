# Simple script to setup a new ts project

echo Folder name

read name

mkdir $name && cd $name

yarn init

yarn add typescript 

yarn add -D @types/node ts-node ts-node-dev rimraf prettier eslint

sed -i '' 's/.js/.ts/g' package.json

entryPoint=$(grep 'main' package.json |  awk -F \: {'print $2'} | cut -d\" -f2 | cut -d\. -f1) 

sed -i '' -e '$ d' package.json        

echo  , >> package.json

cat ../scripts.json >> package.json

echo  } >> package.json

sed -i '' "s/index/$entryPoint/g" package.json

touch $entryPoint.ts

mkdir scr

cp ../tsconfig.json tsconfig.json
cp ../.prettierrc .prettierrc

mkdir .vscode

cp ../launch.json .vscode/launch.json

#TODO: Get files from repo