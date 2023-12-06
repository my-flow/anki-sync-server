#!/usr/bin/env bash
set -EeuoP pipefail

apt-get update
apt-get install --no-install-recommends --yes protobuf-compiler

cargo install \
    --git https://github.com/ankitects/anki.git \
    --tag "${1}" \
    anki-sync-server
