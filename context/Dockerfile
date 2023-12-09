FROM rust:1-slim AS builder1
WORKDIR /usr/local/bin
COPY . .
RUN ./install_healthcheck.sh

FROM rust:1-slim AS builder2
WORKDIR /usr/local/bin
COPY install_anki.sh .
ARG ANKI_VERSION
RUN ./install_anki.sh ${ANKI_VERSION}

FROM gcr.io/distroless/cc-debian12:nonroot
WORKDIR /usr/local/bin
COPY --from=builder1 /usr/local/bin/target/release/healthcheck .
COPY --from=builder2 /usr/local/cargo/bin/anki-sync-server .

ARG SYNC_PORT
EXPOSE ${SYNC_PORT}

ARG HEALTHCHECK_PATH
HEALTHCHECK CMD ["/usr/local/bin/healthcheck"]
ENTRYPOINT [ "anki-sync-server" ]
