FROM rust:1-slim as builder
WORKDIR /usr/local/bin
COPY ./install_anki.sh .

ARG ANKI_VERSION
RUN ./install_anki.sh ${ANKI_VERSION}

FROM debian:bookworm-slim
LABEL maintainer="florian@my-flow.com"
WORKDIR /usr/local/bin
COPY ./install_curl.sh .
RUN ./install_curl.sh
COPY --from=builder /usr/local/cargo/bin/anki-sync-server .

HEALTHCHECK CMD curl http://localhost:${SYNC_PORT}/sync/meta || exit 1

ARG SYNC_PORT
EXPOSE ${SYNC_PORT}

RUN groupadd anki && useradd --gid anki anki
USER anki:anki

ENTRYPOINT [ "anki-sync-server" ]
