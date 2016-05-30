FROM ruby:2.3.0

ENV PHANTOM_VERSION phantomjs-2.1.1-linux-x86_64
ENV NVM_DIR /nvm
ENV NODE_VERSION 5.1

RUN echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc"

RUN wget -q -O - https://bitbucket.org/ariya/phantomjs/downloads/$PHANTOM_VERSION.tar.bz2 | tar xj && \
    mv $PHANTOM_VERSION/bin/phantomjs /usr/local/bin/ && rm -rf $PHANTOM_VERSION/

RUN apt-get update && \
    apt-get install -y build-essential \
    libicu-dev wkhtmltopdf \
    postgresql-client && \
    rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash && \
    source $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && nvm alias default $NODE_VERSION
