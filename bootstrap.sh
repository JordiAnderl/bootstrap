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

curl https://raw.githubusercontent.com/JordiAnderl/bootstrap/main/configs/scripts.json -s -o scripts.json

sed -i '' "s/index/$entryPoint/g" scripts.json
cat scripts.json >> package.json
rm scripts.json

echo  \} >> package.json


touch $entryPoint.ts

mkdir src

# Main configs
curl https://raw.githubusercontent.com/JordiAnderl/bootstrap/main/configs/tsconfig.json -s -o tsconfig.json
curl https://raw.githubusercontent.com/JordiAnderl/bootstrap/main/configs/.prettierrc -s -o .prettierrc
curl https://raw.githubusercontent.com/JordiAnderl/bootstrap/main/configs/.gitignore -s -o .gitignore

# VSCode configs
mkdir .vscode

curl https://raw.githubusercontent.com/JordiAnderl/bootstrap/main/configs/launch.json -s -o launch.json
sed -i '' "s/index/$entryPoint/g" launch.json
mv launch.json .vscode/launch.json

curl https://raw.githubusercontent.com/JordiAnderl/bootstrap/main/configs/settings.json -s -o settings.json
mv settings.json .vscode/settings.json
