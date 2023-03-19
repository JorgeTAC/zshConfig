# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export LANG=en_US.UTF-8
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git nvm)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
Cyan='\033[0;36m'
NC='\033[0m' # No Color
Green='\033[0;32m'

alias zshe="code ~/.zshrc"
alias zshr="source ~/.zshrc && clear" 
alias ionAndroid="ionic build --prod --release && npx cap sync android && npx cap copy android && npx cap open android"
alias ionIos="ionic build --prod --release && npx cap sync ios && npx cap copy ios && npx cap open ios"

# Javascript command line tools
alias nvmpls="node ~/Workspace/Learning/nodejs/ng-manager/src/index.js"
alias vsc="node ~/Workspace/Learning/nodejs/workspace-manager/index.js"

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
  jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore ffmarket.jks -storepass 'ffm4rk3t' -keypass 'ffm4rk3t' android/app/build/outputs/bundle/release/app-release.aab ffmarket
  return
}

zipFFM() {
  ./zipalign -v -p 4 android/app/build/outputs/bundle/release/app-release.aab FFMARKET.aab
  return
}

uploadTrans() {
  cd ~/Workspace/FFMarket/ffmarket_translation && gsutil cp *.json gs://fitfood-22c23.appspot.com/market 
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

# alias ohmyzsh="vim ~/.oh-my-zsh"

# Cocoapods
export GEM_HOME=$HOME/.gem
export PATH=$GEM_HOME/bin:$PATH

# NVM
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

# Visual Studio Code
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jorgeac/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jorgeac/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jorgeac/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jorgeac/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/Users/jorgeac/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Load Angular CLI autocompletion.
source <(ng completion script)
