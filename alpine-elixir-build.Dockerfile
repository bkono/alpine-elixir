FROM bkono/alpine-elixir:1.1.1

ENV REFRESHED_AT 2015-12-02

RUN apk --update add erlang-inets erlang-ssl erlang-public-key erlang-eunit \
    erlang-asn1 erlang-sasl erlang-erl-interface erlang-dev wget git gcc make \
    libc-dev libgcc nodejs && \
    rm -rf /var/cache/apk/*

RUN mix local.hex --force && \
    mix local.rebar --force

CMD ["/bin/sh"]
