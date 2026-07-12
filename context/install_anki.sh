#!/usr/bin/env bash
set -EeuoP pipefail

apt-get update
apt-get install --no-install-recommends --yes protobuf-compiler

export RUSTFLAGS="${RUSTFLAGS:-} -A text_direction_codepoint_in_literal"

cargo install \
    --git https://github.com/ankitects/anki.git \
    --locked \
    --tag "${1}" \
    anki-sync-server
