FROM ubuntu:18.04

# Install requirements
RUN apt-get update
RUN apt-get -y install wget unzip build-essential automake autogen autoconf libtool software-properties-common

# Install ChefDK
RUN wget https://packages.chef.io/files/stable/chefdk/3.0.36/ubuntu/16.04/chefdk_3.0.36-1_amd64.deb
RUN dpkg -i chefdk_3.0.36-1_amd64.deb

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
RUN unzip terraform_0.11.10_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN terraform --version

# Ruby and FPM
RUN apt-get -y install ruby-full
RUN gem install --no-ri --no-rdoc rake
RUN gem install --no-ri --no-rdoc fpm -v 1.9.3

# PHP
RUN add-apt-repository -y ppa:ondrej/php
RUN apt-get -y install imagemagick php-imagick php7.2 php7.2-fpm php7.2-cli php7.2-common php7.2-curl php7.2-json php7.2-mbstring php7.2-mysql php7.2-opcache php7.2-readline php7.2-xml php7.2-intl php7.2-apcu php7.2-apcu-bc php7.2-gmp

# Composer
RUN curl -sS https://getcomposer.org/installer | php7.2 -- --install-dir=/usr/local/bin --filename=composer
