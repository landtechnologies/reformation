#!/bin/bash

# MOVE TO KANJI
xcode-select --install
brew install awscli git docker-compose

# shell

## shell aliases (do we need these? what's in our aliases file?)
rm -Rf "$HOME"/.landtech/aliases
cp -fr ./shell/aliases >"$HOME"/.landtech/aliases
## rc entry
[ -f $HOME/.landtech/aliases ] && source $HOME/.landtech/aliases

# optional term welcome message
## rc entry
export WELCOME_MESSAGE='\e[0m • \e[1;34mCollaboration\e[0m • \e[1;33mExcellence\e[0m • \e[1;31mCreativity\e[0m • \e[1;32mConfidence\e[0m • \e[0m'
[ -z "$WELCOME_MESSAGE" ] || echo -e "$WELCOME_MESSAGE"

# python
brew install pyenv
pyenv install 3.9
pyenv global 3.9
eval "$(pyenv init -)"
pip3 install --upgrade pip pipenv credstash pylint pywatchman
# rc file entry...
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# node
brew install Schniz/tap/fnm
brew install yarn
fnm install 14
fnm default 14
npm install -g prettier eslint
# rc file entry
export PATH="$PATH:./node_modules/.bin"
if command -v fnm 1>/dev/null 2>&1; then
    eval "$(fnm env)"
fi

# brew
brew install...
# password store
gopass
gnupg
# general
coreutils
gnu-sed
grep
jq
moreutils
shellcheck
wget

# awscli
gopass show aws/accounts.json config | jq . >"$HOME/.landtech/accounts.json"
## awscli profiles per env
aws configure set profile.default.region eu-west-1
aws configure set profile.default.output json
for account in $(jq -r 'keys[]' <~/.landtech/accounts.json); do
    aws configure set profile."$account".region eu-west-1
    aws configure set profile."$account".output json
done
## aliases
mkdir -p "$HOME"/.aws/cli
cp -f ./aws-alias "$HOME"/.aws/cli/alias # useful but could overwrite personal aliases
## helpers
rm -Rf "$HOME"/.landtech/bin
cp -f ./aws-assume-role ~/.landtech/bin
cp -f ./aws-get-session-token ~/.landtech/bin
## rc entry
export PATH="$HOME/.landtech/bin:$PATH"
