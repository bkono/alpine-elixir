FROM bkono/alpine-elixir:1.1.1

ENV REFRESHED_AT 2015-12-02
ENV PORT 4000
ENV MIX_ENV prod
EXPOSE $PORT

RUN apk --update add erlang-inets erlang-ssl erlang-public-key erlang-eunit \
    erlang-asn1 erlang-sasl erlang-erl-interface erlang-dev wget git gcc make \
    libc-dev libgcc nodejs && \
    rm -rf /var/cache/apk/*

RUN mix local.hex --force && \
    mix local.rebar --force

ONBUILD RUN mkdir -p /app
ONBUILD ADD . /app
ONBUILD WORKDIR /app

ONBUILD RUN mix do deps.get, compile && \
    npm install && \
    node node_modules/brunch/bin/brunch build --production && \
    mix phoenix.digest

CMD ["mix", "phoenix.server"]
