FROM ruby:2.4

# Install Node
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash -
RUN apt-get -y install nodejs zip sassc locales

# Sett up locales
RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && locale-gen
ENV LC_ALL=en_US.UTF-8

# Install NPM modules
RUN npm install -g uglify-js less

# Install Rake (just in case)
RUN gem install rake aws-sdk

# Copy the gem over & Install
COPY ./joomla-rake-2.3.7.gem /tmp
RUN gem install /tmp/joomla-rake-2.3.7.gem

WORKDIR /app
CMD [ "/usr/local/bundle/bin/rake" ]
