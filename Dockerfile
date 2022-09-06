FROM bitwalker/alpine-elixir:1.13.4 AS build
LABEL maintainer="email@smaple.com"

RUN apk update && apk add --no-cache ncurses-libs postgresql-client build-base openssh-client

RUN mkdir /root/.ssh

RUN ssh-keyscan github.com >> /root/.ssh/known_hosts

WORKDIR /app

ARG MIX_ENV=prod

RUN mix do local.hex --force, local.rebar --force

COPY mix.exs mix.lock ./
COPY config config

RUN --mount=type=ssh mix do deps.get, deps.compile

COPY . ./
RUN mix do compile --warnings-as-errors, release

# production stage
FROM alpine:3.12 AS production

# install dependencies
RUN apk upgrade --no-cache && \
  apk add ncurses-libs curl libgcc libstdc++

# start application
COPY start.sh ./
CMD ["sh", "./start.sh"]
