#!/bin/sh

# Pretty print messages
print_header() {
    length=${#1}
    line=`printf '%*s' $length | tr ' ' "="`
    echo -e '\n'$line
    echo -e $1
    echo -e "$line\n"
}

print_header "updating ubuntu"
#Add repositories for QGIS, Sublime Text 3, R and Tor Browser bundle
echo "deb http://qgis.org/debian xenial main" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://qgis.org/debian xenial main" | sudo tee -a /etc/apt/sources.list

#add gpg key for qgis download and install
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key CAEB3DC3BDF7FB45

# add gpg key for Sublime Text 3
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# allow apt to work with https sources
sudo apt-get install apt-transport-https

# select the stable version of Sublime Text 3
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo add-apt-repository -y ppa:webupd8team/tor-browser

# point apt to the ubuntu repository for R
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list

# add gpg key for R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key E084DAB9


#Update apt-get and upgrade packages
sudo apt-get -qq update
sudo apt-get -qq upgrade

# development
print_header "Installing development tools"
sudo apt-get -qq install build-essential fortune cowsay

# Git
print_header "Installing git"
sudo apt-get -qq install git-core

# Sublime Text 3
print_header "Installing Sublime Text 3"
sudo apt-get install sublime-text

# Adding curl
sudo apt-get install curl

# pyenv
print_header "Installing pyenv"
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

echo 'export PATH="/home/nicar/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

source ~/.bashrc

pyenv update

pyenv install 3.6.4
pyenv install 2.7.14

pyenv global 3.6.4

mkdir code
mkdir code/python2 && cd $_
pyenv virtualenv 2.7.14 python-2
cd ..
mkdir python3 && cd $_
pyenv virtualenv 3.6.4 python-3
cd ~

# R and R-Studio
print_header "Installing R"
sudo apt-get install r-base r-base-dev

# python scientific stack
print_header "Installing python scientific stack"
sudo apt-get -qq install python-numpy python-scipy python-matplotlib python-dev python-pip python-sip pyqt4-dev-tools

# various Python libraries we like
print_header "pip installing favored Python libraries"
sudo pip install --quiet jupyter
sudo pip install --quiet beautifulsoup4
sudo pip install --quiet requests
sudo pip install --quiet django==1.11.10
sudo pip install --quiet pandas
sudo pip install --quiet csvkit
sudo pip install --quiet miditime
sudo pip install --quiet flask
sudo pip install --quiet agate
sudo pip install --quiet psycopg2
sudo pip install --quiet altair

# enable ipyvega for altair to work
sudo jupyter nbextension enable --sys-prefix --py vega


# postgres
print_header "installing latest PostgreSQL and PostGIS"
sudo apt-get install -qq postgresql
sudo apt-get install -qq postgis

echo "  IMPORTANT: Remember to create a Postgres superuser for your user!"

sudo -u postgres createuser -s nicar

# MySQL
print_header "Installing MySQL"
sudo apt-get -qq install mysql-server mysql-client libmysqlclient-dev

# Sqlite3
print_header "Installing Sqlite3"
sudo apt-get install sqlite3 libsqlite3-dev

#qgis
print_header "installing QGIS"

sudo apt-get install -y qgis python-qgis

#pspp
print_header "installing PSPP"
sudo apt-get install pspp

# node.js
print_header "installing Node.js"
sudo apt-get -qq install nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node

#npm
sudo apt-get install -y npm


#Tor Browser
sudo apt-get install tor-browser

#install Java
print_header "installing Java"
sudo apt-get -qq install default-jre

#install ILENE
git clone https://github.com/thejefflarson/ILENE
cd ILENE
npm install
cd

# Install Ruby
print_header "installing Ruby, rbenv and ruby-build"

#install dependencies
sudo apt-get install -qq autoconf bison libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm3 libgdbm-dev

#install rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

#install ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

source ~/.bashrc

#install latest stable version of Ruby
rbenv install 2.2.0
rbenv global 2.2.0


#install jruby
# print_header "installing jruby for Tabula"
# rbenv install jruby-1.7.18
# #install Tabula extractor for awesome command line pdf extraction
# echo " Setting up Tabula"
# mkdir tabula
# cd tabula
# rbenv local jruby-1.7.18
# jruby -S gem install tabula-extractor
# cd # return home

#perform one last upgrade to all software packages
sudo apt-get upgrade

# randomly generate animal
# animals=$(cowsay -l | tail -n+2 | shuf)
# test=" " read -a array <<< "$animals"

# # cowsay
# cowsay -f ${array[2]} "All done! Now, go save journalism!"
cowsay "All done! Now, go save journalism!"
