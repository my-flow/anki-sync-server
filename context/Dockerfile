FROM rust:1.91.0-slim AS builder
WORKDIR /usr/local/bin
COPY install_anki.sh .
ARG ANKI_VERSION
RUN ./install_anki.sh ${ANKI_VERSION}

FROM gcr.io/distroless/cc-debian12:nonroot
WORKDIR /usr/local/bin
COPY --from=builder /usr/local/cargo/bin/anki-sync-server .

ARG SYNC_PORT
EXPOSE ${SYNC_PORT}

ARG HEALTHCHECK_PATH
HEALTHCHECK CMD ["anki-sync-server", "--healthcheck"]
ENTRYPOINT [ "anki-sync-server" ]
