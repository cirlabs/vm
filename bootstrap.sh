#!/bin/sh

echo "updating ubuntu"
sudo apt-get -qq update
sudo apt-get -qq upgrade

# development
echo "installing development tools"
sudo apt-get -qq install build-essential fortune cowsay # hehehe

# Git
echo "installing git"
sudo apt-get -qq install git-core

# zsh
echo "installing zsh and oh-my-zsh"
wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh

# python scientific stack
echo "installing python scientific stack"
sudo apt-get -qq install python-numpy python-scipy python-matplotlib ipython ipython-doc ipython-notebook ipython-qtconsole python-virtualenv python-dev python-pip python-sip pyqt4-dev-tools

# various Python libraries we like
echo "pip installing favored Python libraries"
sudo pip install --quiet beautifulsoup4
sudo pip install --quiet requests
sudo pip install --quiet django
sudo pip install --quiet virtualenvwrapper
sudo pip install --quiet pandas
sudo pip install --quiet csvkit

# make sure virtalenvwrapper is loaded and works
echo "setting up virtualenvwrapper"
mkdir .envs
echo "# virtualenvwrapper\nexport WORKON_HOME=$HOME/.envs\nsource /usr/local/bin/virtualenvwrapper.sh" >> ~/.bashrc
echo "# virtualenvwrapper\nexport WORKON_HOME=$HOME/.envs\nsource /usr/local/bin/virtualenvwrapper.sh" >> ~/.zshrc


# postgres
echo "installing latest PostgreSQL and PostGIS"
sudo apt-get install -qq postgresql
sudo apt-get install -qq postgis

# create superuser for for self
# sudo su - postgres
# createuser -s [your user name]
# exit

# MySQL
echo "Installing MySQL"
sudo apt-get -qq install mysql-server mysql-client libmysqlclient-dev

#qgis
echo "installing QGIS"
sudo apt-get install qgis

# node.js
echo "installing Node.js"
sudo apt-get -qq install nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node


#install Java
echo "installing Java"
sudo apt-get -qq install default-jre

# Install Ruby
echo "install Ruby, rbenv and ruby-build"

#install dependencies
sudo apt-get install -qq autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

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
rbenv global 2.2.0


#install jruby
echo "installing jruby for Tabula"
rbenv install jruby-1.7.18
#install Tabula extractor for awesome command line pdf extraction
echo "Setting up Tabula"
mkdir tabula
cd tabula
rbenv local jruby-1.7.18
jruby -S gem install tabula-extractor
cd ~

echo "All done! Go save journalism!"
