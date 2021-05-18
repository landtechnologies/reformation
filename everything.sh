#!/bin/bash

# xcode (Kanji?)
xcode-select --install

# shell
## shell aliases
rm -Rf "$HOME"/.landtech/aliases
gopass show shell/aliases >"$HOME"/.landtech/aliases
## bin folder scripts (quite k8s orientated, but handy mechanism)
rm -Rf "$HOME"/.landtech/bin
cp -fr ./bin "$HOME"/.landtech/bin
## variables
export PATH="$REFORMATION_DIR:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.landtech/bin:$PATH"
export PATH="$PATH:./node_modules/.bin"
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH:$PATH"
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export WELCOME_MESSAGE='\e[0m • \e[1;34mCollaboration\e[0m • \e[1;33mExcellence\e[0m • \e[1;31mCreativity\e[0m • \e[1;32mConfidence\e[0m • \e[0m'
[ -z "$WELCOME_MESSAGE" ] || echo -e "$WELCOME_MESSAGE"
## rc entry
[ -f $HOME/.landtech/aliases ] && source $HOME/.landtech/aliases

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
if command -v fnm 1>/dev/null 2>&1; then
    eval "$(fnm env)"
fi

# brew
brew install...
awscli
# kubernetes
aws-iam-authenticator
jsonnet
# docker
docker-compose
# password store
gopass
gnupg
# bash testing
bats-core
# general
bash
coreutils
git
gnu-sed
gh
grep
jq
moreutils
shellcheck
wget
watchman
python-yq

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
## helper scripts
cp -f ./aws-assume-role ~/.bin # ~/.bin needs to be in PATH
cp -f ./aws-get-session-token ~/.bin

# SSH
## not included, but it's a landtech config
## one thing is does allow is shortened ssh names, ie jumpbox.some.long.eu-west1.amws.ec2.name => jumpbox
## but this could be achieved with DNS in some cases!
