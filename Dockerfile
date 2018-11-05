FROM ubuntu:18.04

# Install requirements
RUN apt-get update
RUN apt-get -y install wget unzip build-essential

# Install ChefDK
RUN wget https://packages.chef.io/files/stable/chefdk/3.0.36/ubuntu/16.04/chefdk_3.0.36-1_amd64.deb
RUN dpkg -i chefdk_3.0.36-1_amd64.deb

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
RUN unzip terraform_0.11.10_linux_amd64.zip
RUN mv terraform /usr/local/bin/
RUN terraform --version
