#!/usr/bin/env bash
set -EeuoP pipefail

apt-get update
apt-get install --no-install-recommends --yes curl

apt-get purge --auto-remove --yes
rm -rf /var/lib/apt/lists/*
