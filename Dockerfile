FROM rust:bookworm AS builder
WORKDIR /build
COPY . .
RUN cargo build --release -p relay
RUN cp target/release/relay /output

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl jq ca-certificates fuse3 rclone certbot openssl python3-pip && \
    rm -rf /var/lib/apt/lists/*
RUN pip3 install certbot-dns-bunny --break-system-packages
COPY --from=builder /output /usr/local/bin/relay
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
