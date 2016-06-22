FROM ubuntu:14.04

# Install add-apt-repository
RUN apt-get update
RUN sudo apt-get install -y curl

# Install Salt
RUN curl -sSL https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
RUN echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" > /etc/apt/sources.list.d/saltstack.list
RUN apt-get update
RUN apt-get install --force-yes -y salt-master

COPY etc/salt/master /etc/salt/master

CMD 'salt-master'