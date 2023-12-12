# anki-sync-server

[![Last commit](https://img.shields.io/github/last-commit/my-flow/anki-sync-server)](https://github.com/my-flow/anki-sync-server/commits/develop)
[![Github version](https://img.shields.io/github/v/tag/my-flow/anki-sync-server?label=github%20version)](https://github.com/my-flow/anki-sync-server/releases)
[![DockerHub version](https://img.shields.io/docker/v/myflow/anki-sync-server?label=dockerhub%20version&sort=date)](https://hub.docker.com/repository/docker/myflow/anki-sync-server)
[![DockerHub pulls](https://img.shields.io/docker/pulls/myflow/anki-sync-server)](https://hub.docker.com/repository/docker/myflow/anki-sync-server)
[![DockerHub stars](https://img.shields.io/docker/stars/myflow/anki-sync-server)](https://hub.docker.com/repository/docker/myflow/anki-sync-server)

[Anki][https://apps.ankiweb.net/] is a powerful open source flashcard application, which helps you
quickly and easily memorize facts over the long term utilizing a spaced
repetition algorithm. Anki's main form is a desktop application (for Windows,
Linux and macOS) which can sync to a web version (AnkiWeb) and mobile
versions for Android and iOS.

This is a personal Anki server, which you can sync against instead of
AnkiWeb.

# Docker
```
docker run \
    --env-file ./.env \
    --publish 80:27701 \
    --volume ./data:/data \
    myflow/anki-sync-server:23.10.1
```

# Docker-compose
```
version: "3.8"
services:
  anki-sync-server:
    image: myflow/anki-sync-server:23.10.1
    env_file: .env
    volumes:
      - ./data:/data
    ports:
      - 80:27701
```

# Environment Variables
|Name|Default Value|
|:-|:-|
|SYNC_USER1|whatever@example.com:pa$$word|
|SYNC_BASE|/data|
|SYNC_PORT|27701|
|HEALTHCHECK_PATH|/sync/hostKey|