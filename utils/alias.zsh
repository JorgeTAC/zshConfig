alias sysd="nvm use 10 && npm run ionic:build && nvm use 14.21.1 && firebase deploy --only hosting && nvm use node"
alias zshe="code ~/config"
alias zshr="source ~/.zshrc && clear" 
alias ionAndroid="ionic build --prod --release && npx cap sync android && npx cap copy android && npx cap open android"
alias ionIos="ionic build --prod --release && npx cap sync ios && npx cap copy ios && npx cap open ios"

# Javascript command line tools
alias nvmpls="node ~/Workspace/Learning/nodejs/nvmpls/src/index.js"
alias vsc="node ~/Workspace/Learning/nodejs/workspace-manager/index.js"

# Git aliases
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gpl="git pull"
alias gplf="git pull --force"
alias gp="git push"
alias gpf="git push --force"
alias gpo="git push origin"


