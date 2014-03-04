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

# python scientific stack
echo "installing python scientific stack"
sudo apt-get -qq install python-numpy python-scipy python-matplotlib ipython ipython-doc ipython-notebook ipython-qtconsole python-virtualenv python-dev python-pip python-sip pyqt4-dev-tools

sudo pip install bs4 beautifulsoup requests django virtualenvwrapper pandas csvkit

# postgres
echo "installing PostgreSQL 9.3 and PostGIS 2.1"
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" >> /etc/apt/sources.list'
wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get -qq install Postgresql-9.3-postgis pgadmin3 postgresql-contrib libpq-dev

# create superuser for for self
sudo su - postgres
createuser -s [your user name]
exit

# MySQL
sudo apt-get -qq install mysql-server mysql-client libmysqlclient-dev

#qgis
echo "installing QGIS"
# this may change based on your ubuntu distro
# See http://www.qgis.org/en/site/forusers/alldownloads.html#qgis-stable
# Assuming 13.10 Saucy ...
sudo sh -c 'echo "deb     http://qgis.org/debian saucy main" >> /etc/apt/sources.list'
sudo sh -c 'echo "deb-src http://qgis.org/debian saucy main" >> /etc/apt/sources.list'

# keyerror fix
gpg --keyserver keyserver.ubuntu.com --recv 47765B75
gpg --export --armor 47765B75 | sudo apt-key add -

# install
sudo apt-get update
sudo apt-get -qq install qgis python-qgis

# Node
# Node/NPM is weird on Ubuntu. If you install node/npm using sudo, then your filesystem will throw permission errors when 
# doing local installs of node modules. I'm not entirely sure why this is an issue, but needless to say, you'll run into 
# problems when working with node packages.

# A solution to this is to make node locally and install stuff with npm from your user. 
# As a result, you won't need to run sudo to install node dependencies and your life will be easier. 
# Pick your poison:

# Version 1
echo "installing Node.js"
sudo apt-get update
sudo apt-get -qq install -y python-software-properties python g++ make
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo apt-get -qq install nodejs

# Install node libraries
echo "installing node-based tools"
sudo npm install -g grunt-cli yo bower generator-newsapp

# Version 2
# Modified from
# http://increaseyourgeek.wordpress.com/2010/08/18/install-node-js-without-using-sudo/

wget http://nodejs.org/dist/v0.10.25/node-v0.10.25.tar.gz
tar -xvzf node-v0.10.25.tar.gz
cd node-v0.10.25
mkdir ~/.node
./configure --prefix=~/.node
make
make install
echo 'export PATH=~/.node/bin:${PATH}' >> ~/.zshrc
# this may happen automatically so check first
echo "export NODE_PATH=$NODE_PATH:/$HOME/.node/lib/node_modules" >> ~/.zshrc && source ~/.zshrc

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