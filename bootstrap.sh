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
echo "install Ruby and Ruby Version Manager (RVM)"
# Ruby dependencies
sudo apt-get -qq install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev

# RVM dependencies 
sudo apt-get -qq install libgdbm-dev libncurses5-dev automake libtool bison libffi-dev

# install RVM
curl -L https://get.rvm.io | bash -s stable
source ~/.rvm/scripts/rvm
echo "source ~/.rvm/scripts/rvm" >> ~/.bashrc
echo "source ~/.rvm/scripts/rvm" >> ~/.zshrc
rvm install 2.1.0
rvm use 2.1.0 --default

# virtualbox helpers
# sudo apt-get -qq install virtualbox-ose-guest-utils virtualbox-ose-guest-x11 virtualbox-ose-guest-dkms
