#!/usr/bin/env bash

# [config] VARIABLES
VAGRANT_HOME="/home/vagrant"
RUBY_VERSION="2.2.1"
NVM_VERSION="v0.30.1"
NODE_VERSION="stable"
DOCKER_COMPOSE_VERSION="1.5.2"

# [config] LOCALE
locale-gen es_ES.UTF-8
update-locale LANG=es_ES.UTF-8
update-locale LC_ALL=es_ES.UTF-8

sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list
apt-get update

# [install] EXTRA KERNEL (recommended for Docker)
apt-get install -y linux-image-extra-$(uname -r)

# [install] BASIC TOOLS
apt-get install -y \
  build-essential \
  software-properties-common \
  autoconf \
  automake \
  git \
  curl \
  wget \
  htop \
  man \
  vim

# [install] COMPRESSION TOOLS
apt-get install -y \
  tar \
  gzip \
  zip \
  unzip \
  rar \
  unace \
  p7zip-full \
  p7zip-rar \
  sharutils \
  mpack \
  arj

# [install] ZSH
apt-get install -y zsh
su - vagrant -c "wget --no-check-certificate https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O - | sh"
chsh -s /bin/zsh vagrant

# [install] PYTHON
apt-get install -y \
  python \
  python-dev \
  python-pip \
  python-virtualenv

# [install] RUBY
su - vagrant -c 'curl -sSL https://rvm.io/mpapis.asc | gpg --import -'
su - vagrant -c 'curl -sSL https://get.rvm.io | bash -s stable --ruby'
su - vagrant -c "source $VAGRANT_HOME/.rvm/bin/rvm"
su - vagrant --login -c "rvm install $RUBY_VERSION"
su - vagrant --login -c "rvm --default use $RUBY_VERSION"
su - vagrant --login -c 'rvm rvmrc warning ignore allGemfiles'
su - vagrant --login -c 'gem install rake capistrano'

# [install] NODE.JS
su - vagrant -c "wget --no-check-certificate https://raw.githubusercontent.com/creationix/nvm/$NVM_VERSION/install.sh -O - | sh"
su - vagrant --login -c "source $VAGRANT_HOME/.nvm/nvm.sh"
su - vagrant --login -c "nvm install $NODE_VERSION"
su - vagrant --login -c 'nvm alias default stable'

# [install] JAVA 8
su - root -c 'echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections'
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install -y oracle-java8-installer ca-certificates

# [install] DOCKER
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo 'deb https://apt.dockerproject.org/repo ubuntu-trusty main' > /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-engine
groupadd docker
gpasswd -a vagrant docker
echo "Added docker group to vagrant user. Remember to restart your login session."

# [install] DOCKER-COMPOSE
curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m) > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# [entrypoint] ZSH
zsh --login
