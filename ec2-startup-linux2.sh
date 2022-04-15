#!/bin/sh

# update instance packages
sudo yum update -y

# move to correct directory
cd /home/ec2-user

# setup code deploy agent
sudo yum install -y ruby
sudo yum install wget
wget https://aws-codedeploy-eu-west-2.s3.eu-west-2.amazonaws.com/latest/install
chmod +x ./install
sudo ./install auto
sudo service codedeploy-agent start
rm ./install -f

# install jdk 17
wget https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.rpm
sudo rpm -Uvh jdk-17_linux-x64_bin.rpm
sudo rm jdk-17_linux-x64_bin.rpm

# logs folder
mkdir logs
sudo chmod -R a+rw ./logs