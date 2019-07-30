FROM ruby:2.3.7
MAINTAINER Antony Hutchison <antony@hutchisontechnical.co.uk>

# Env
ENV PHANTOMJS_VERSION 1.9.7

# Commands
RUN \
apt-get update && \
apt-get upgrade -y && \
apt-get install -y git wget libfreetype6 libfontconfig bzip2 && \
mkdir -p /srv/var && \
wget -q --no-check-certificate -O /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
tar -xjf /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 -C /tmp && \
rm -f /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64.tar.bz2 && \
mv /tmp/phantomjs-$PHANTOMJS_VERSION-linux-x86_64/ /srv/var/phantomjs && \
ln -s /srv/var/phantomjs/bin/phantomjs /usr/bin/phantomjs && \
git clone https://github.com/n1k0/casperjs.git /srv/var/casperjs && \
ln -s /srv/var/casperjs/bin/casperjs /usr/bin/casperjs && \
apt-get autoremove -y && \
apt-get clean all

VOLUME ["/data"]

# Define working directory.
WORKDIR /data

ADD . /data
# add the requirements to the gem install line instead, otherwise it runs bundler every single change
RUN bundle install

#CMD ["cucumber"]

