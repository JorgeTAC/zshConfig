Cyan='\033[0;36m'
NC='\033[0m' # No Color
Green='\033[0;32m'
# Create a help function to list all the aliases
function ayuda () {
  echo "${Green}  List of aliases:  ${NC}"
  echo "${Green}------------------------${NC}"
  echo "${Cyan} zshe ${NC}: edit zshrc file"
  echo "${Cyan} zshr ${NC}: reload zshrc file"
  echo "${Cyan} fbd ${NC}: deploy firebase hosting"
  echo "${Cyan} ionAndroid ${NC}: build and open android project"
  echo "${Cyan} ionIos ${NC}: build and open ios project"
  echo "${Cyan} nvmpls ${NC}: run nvmpls"
  echo "${Cyan} vsc ${NC}: run vsc"
  echo "${Cyan} tscw ${NC}: run tsc --watch"
  echo "${Cyan} firmFFM ${NC}: firmar apk"
  echo "${Cyan} zipFFM ${NC}: zip apk"
  echo "${Cyan} uploadTrans ${NC}: upload translations"
  echo "${Cyan} fbs ${NC}: firebase serve"
  echo "${Cyan} fbe ${NC}: firebase emulators:start"  
  echo "${Cyan} ngs ${NC}: ng serve"
  echo "${Cyan} ngb ${NC}: ng build"
  echo "${Cyan} ion ${NC}: ionic serve"
  echo "${Green}------------------------${NC}"
  return
}


# function to execute the command node_modules/.bin/tsc --watch and detect if the folder is functions
function tscw () {
  # check if actual folder is named functions
  if [ -d "functions" ]; then
    cd functions
  fi
  node_modules/.bin/tsc --watch
  return
}

firmFFM() {
  jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ffmarket.jks -storepass 'ffm4rk3t' -keypass 'ffm4rk3t' android/app/build/outputs/apk/release/app-release-unsigned.apk ffmarket
  return
}

zipFFM() {
  ./zipalign -v -p 4 android/app/build/outputs/apk/release/app-release-unsigned.apk FFMARKET.apk
  return
}

uploadTrans() {
  cd ~/Workspace/FFMarket/ffmarket_translation && gsutil cp *.json gs://fitfood-22c23.appspot.com/market && git add . && git commit -m "[bot] Upload translations" && git push origin
  return
}

function fbs () {
 while [[ "$#" -gt 0 ]]
do case $1 in
    -p|--port) port="$2"
    shift;;
esac
shift
done
# check if actual folder is named functions
if [ -d "functions" ]; then
  cd functions
fi

 nvm use 14.21.1 && firebase serve --only functions --port $port
}

fbe() {
  if [[ $1 =~ ^(-o|--only) ]]
  then
      only="$2"
  fi

  if [  $# -eq 0 ]
  then
    only="0"
  fi

  if [ only -eq 0 ]
  then 
    nvm use 14.21.1 && firebase emulators:start
    return
  fi

  nvm use 14.21.1 && firebase emulators:start --only $only

}

ngs() {
  if [ $# -eq 0 ]
  then
    echo "Usage: ngs <version> <enviroment>"
    ng serve -o
    return
  fi
  if [ $# -lt 1 ]
  then
    nvm use $1 && ng serve -o
    return
  fi
  if [ $# -lt 2 ]
  then
    nvm use $1 && ng serve -o --configuration=$2
    return
  fi
  nvm use $1 && ng serve -o --configuration=$2 --port=$3

  return
}

ngb() {
  if [ $# -eq 0 ]
  then
    echo "Usage: ngs <version> <enviroment>"
    return
  fi
  if [ $# -lt 2 ]
  then
    nvm use $1 && ng build --prod && nvm use 14.21.1 && firebase deploy --only hosting
    return
  fi


  return
} 

ions() {
  if [ $# -lt 0 ]
  then
    echo "Usage: ions <version> <enviroment>"
    ionic serve -o
    return
  fi

  if [ $# -lt 1 ]
  then
    nvm use $1 && ionic serve -o
    return
  fi
  if [ $# -lt 2 ]
  then
    nvm use $1 && ionic serve -o --configuration=$2
    return
  fi
  nvm use $1 && ionic serve -o --configuration=$2 --port=$3
  return
}

function npmi() {
  if [ $# -eq 0 ]
  then
    echo "Usage: npmi <package> "
    npm install
    return
  fi
  if [ $# -lt 1 ]
  then npm install $2 $3 $4 $5 $6 $7 $8 $9
    return
  fi
  return
}