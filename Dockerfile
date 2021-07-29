FROM node:12 AS assets

WORKDIR /assets
COPY assets .

RUN npm install

FROM elixir:1.12

RUN apt update && apt install -y inotify-tools

COPY . .
COPY --from=assets /assets .

RUN mix local.hex --force && mix local.rebar --force
RUN mix deps.get
