FROM ubuntu:14.04

# Install add-apt-repository
RUN apt-get update
RUN sudo apt-get install -y curl

# Install Salt
RUN curl -sSL https://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest/SALTSTACK-GPG-KEY.pub | sudo apt-key add -
RUN echo "deb http://repo.saltstack.com/apt/ubuntu/14.04/amd64/latest trusty main" > /etc/apt/sources.list.d/saltstack.list
RUN apt-get update
RUN apt-get install --force-yes -y salt-minion

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN apt-get install -y nodejs

# Install Demo application
RUN mkdir -p /var/www/app
WORKDIR /var/www/app
COPY app/src ./src
COPY app/package.json ./
COPY app/config.yml ./
COPY app/secrets.yml ./
RUN npm install

# Install Supervisor
RUN apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN mkdir -p /var/log/supervisord

# Install Summon
RUN mkdir -p /usr/local/lib/summon
WORKDIR /usr/local/bin
RUN curl -sSL https://github.com/conjurinc/summon/releases/download/v0.6.0/summon_v0.6.0_linux_amd64.tar.gz | tar xvz
WORKDIR /usr/local/lib/summon
RUN curl -sSL https://github.com/conjurinc/summon-conjur/releases/download/v0.1.4/summon-conjur_v0.1.4_linux-amd64.tar.gz | tar xvz

WORKDIR /

CMD 'salt-minion'