#!/bin/bash

echo -e 'y\n' | ssh-keygen -q -t rsa -N "" -f ~/.ssh/id_rsa
echo -e '\n'

wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.25.4/install.sh | bash

source ~/.nvm/nvm.sh

nvm install stable
nvm alias default stable

pushd ~/.nvm
    git checkout `git describe --abbrev=0 --tags`
popd

clear
mkdir -p ~/.config/fish

pushd ~/.config/fish
    git clone git://github.com/passcod/nvm-fish-wrapper.git nvm-wrapper
popd

# Ask to run as root
(( EUID != 0 )) && exec sudo -- "$0" "$@"

apt-get update
echo Downloading Atom.io
wget -qO- https://github.com/atom/atom/releases/download/v1.0.3/atom-amd64.deb > atom.deb
dpkg -i atom.deb
rm atom.deb

apt-get install -y build-essential
apt-add-repository -y ppa:fish-shell/release-2
apt-get update
apt-get install -y fish

apt-get install -y vim sl
apt-get install -s -y krita --no-install-recommends
