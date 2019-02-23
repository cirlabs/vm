#!/usr/bin/env bash

# Pretty print messages
print_header() {
    length=${#1}
    line=`printf '%*s' $length | tr ' ' "="`
    echo -e '\n'$line
    echo -e $1
    echo -e "$line\n"
}


print_header "Updating Ubuntu"
# Add repositories for QGIS, Sublime Text 3, R and Tor Browser bundle
echo "deb http://qgis.org/debian bionic main" | sudo tee -a /etc/apt/sources.list
echo "deb-src http://qgis.org/debian bionic main" | sudo tee -a /etc/apt/sources.list

# add gpg key for qgis download and install
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key CAEB3DC3BDF7FB45

# add gpg key for Sublime Text 3
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -

# allow apt to work with https sources
sudo apt-get install apt-transport-https

# select the stable version of Sublime Text 3
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

# point apt to the ubuntu repository for R
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu bionic/" | sudo tee -a /etc/apt/sources.list

# add gpg key for R
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key E084DAB9


#Update apt-get and upgrade packages
sudo apt-get -qq update
sudo apt-get -qq upgrade

# development
print_header "Installing development tools"
sudo apt-get -qq install build-essential fortune cowsay make libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev

# Git
print_header "Installing Git"
sudo apt-get -qq install git-core

# Sublime Text 3
print_header "Installing Sublime Text 3"
sudo apt-get install sublime-text

# Adding curl
sudo apt-get install curl

# R and R-Studio
print_header "Installing R"
sudo apt-get install r-base r-base-dev

# pyenv
print_header "Installing pyenv"
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

echo 'export PATH="/home/nicar/.pyenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc


# Install Ruby
print_header "installing Ruby, rbenv and ruby-build"

# Install dependencies
sudo apt-get install -qq autoconf bison libyaml-dev libreadline6-dev libffi-dev libgdbm3 libgdbm-dev

# Install rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc

source ~/.bashrc

# Install ruby-build
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build


# Install latest stable version of Ruby
rbenv install 2.6.1
rbenv global 2.6.1

sudo chown -R nicar:nicar .pyenv
sudo chown -R nicar:nicar .rbenv

pyenv update

print_header "Installing Python 3"
pyenv install 3.7.2
print_header "Installing Python 2"
pyenv install 2.7.15
print_header "Setting 3.7.2 as the default Python version"
pyenv global 3.7.2
print_header "Creating virtual environments"
mkdir code
mkdir code/python2 && cd $_
pyenv virtualenv 2.7.15 python-2
pyenv local python-2
cd ..
mkdir python3 && cd $_
pyenv virtualenv 3.7.2 python-3
pyenv local python-3
cd ~

# python scientific stack
print_header "Installing Python scientific stack"
sudo apt-get -qq install python-numpy python-scipy python-matplotlib python-dev python-pip python-sip pyqt4-dev-tools

# various Python libraries we like
print_header "pip installing favored Python libraries"
pip install --quiet --upgrade pip
pip install --quiet jupyter
pip install --quiet beautifulsoup4
pip install --quiet requests
pip install --quiet django
pip install --quiet pandas
pip install --quiet csvkit
pip install --quiet miditime
pip install --quiet flask
pip install --quiet agate
pip install --quiet psycopg2
pip install --quiet vega3
pip install --quiet altair

# enable ipyvega for altair to work
source .bashrc
jupyter nbextension install --sys-prefix --py vega3
jupyter nbextension enable vega3 --py --sys-prefix

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
print_header "Installing SQLite3"
sudo apt-get install sqlite3 libsqlite3-dev

#qgis
print_header "Installing QGIS"

sudo apt-get install -y qgis python-qgis

#pspp
print_header "Installing PSPP"
sudo apt-get install pspp

# node.js
print_header "Installing Node.js"
sudo apt-get -qq install nodejs
sudo ln -s /usr/bin/nodejs /usr/bin/node


#npm
sudo apt-get install -y npm


#Tor Browser
sudo apt-get install tor


#install Java
print_header "Installing Java"
sudo apt-get -qq install default-jre

#install ILENE
git clone https://github.com/thejefflarson/ILENE
cd ILENE
npm install
cd

#perform one last upgrade to all software packages
sudo apt-get upgrade

# cowsay -f ${array[2]} "All done! Now, go save journalism!"
cowsay "All done! Now, go save journalism!"
