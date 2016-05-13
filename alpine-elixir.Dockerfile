FROM alpine:3.2
MAINTAINER Bryan Konowitz <bryan@kono.sh>

ENV REFRESHED_AT 2016-05-13
ENV ELIXIR_VERSION 1.2.5

# Set the locale
ENV LANG C.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo 'http://dl-4.alpinelinux.org/alpine/edge/main' >> /etc/apk/repositories && \
    echo 'http://dl-4.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk --update add ncurses-libs erlang-crypto erlang-syntax-tools erlang-xmerl erlang-parsetools && \
    apk --update add --virtual build-dependencies wget ca-certificates && \
    wget --no-check-certificate https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    mkdir -p /opt/elixir-${ELIXIR_VERSION}/ && \
    unzip Precompiled.zip -d /opt/elixir-${ELIXIR_VERSION}/ && \
    rm Precompiled.zip && \
    ln -s /opt/elixir-${ELIXIR_VERSION}/bin/elixirc /usr/local/bin/elixirc && \
    ln -s /opt/elixir-${ELIXIR_VERSION}/bin/elixir /usr/local/bin/elixir && \
    ln -s /opt/elixir-${ELIXIR_VERSION}/bin/mix /usr/local/bin/mix && \
    ln -s /opt/elixir-${ELIXIR_VERSION}/bin/iex /usr/local/bin/iex && \
    apk del build-dependencies && \
    rm -rf /etc/ssl && \
    rm -rf /var/cache/apk/*

CMD ["/bin/sh"]
