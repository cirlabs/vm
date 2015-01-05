#!/bin/sh

echo "updating ubuntu"
sudo apt-get -qq update
sudo apt-get -qq upgrade

# development
echo "installing development tools"
sudo apt-get -qq install build-essential

# Git
echo "installing git"
sudo apt-get -qq install git-core

# zsh
echo "installing zsh and oh-my-zsh"
wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# python scientific stack
echo "installing python scientific stack"
sudo apt-get -qq install python-numpy python-scipy python-matplotlib ipython ipython-doc ipython-notebook ipython-qtconsole python-virtualenv python-dev python-pip python-sip pyqt4-dev-tools

sudo pip install bs4 beautifulsoup requests django virtualenvwrapper pandas csvkit

# postgres
echo "installing PostgreSQL 9.3 and PostGIS 2.1"
sudo apt-get install postgresql
sudo apt-get install postgis

# create superuser for for self
# sudo su - postgres
# createuser -s [your user name]
# exit

# MySQL
sudo apt-get -qq install mysql-server mysql-client libmysqlclient-dev

#qgis
echo "installing QGIS"

sudo apt-get install qgis

# Node
# Node/NPM is weird on Ubuntu. If you install node/npm using sudo, then your filesystem will throw permission errors when 
# doing local installs of node modules. I'm not entirely sure why this is an issue, but needless to say, you'll run into 
# problems when working with node packages.

# A solution to this is to make node locally and install stuff with npm from your user. 
# As a result, you won't need to run sudo to install node dependencies and your life will be easier. 
# Pick your poison:

# Version 1
echo "installing Node.js"

sudo apt-get -qq install nodejs

sudo ln -s /usr/bin/nodejs /usr/bin/node


# Install Ruby
echo "install Ruby, rbenv and ruby-build"

#install dependencies

sudo apt-get install autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

#install rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc

#install ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

source ~/.bashrc
source ~/.zshrc

#install latest stable version of Ruby
rbenv install 2.2.0



# virtualbox helpers
# sudo apt-get -qq install virtualbox-ose-guest-utils virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms
