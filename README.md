# MOQtail

Draft 14-compliant MOQT protocol libraries for publisher, subscriber and relay components, featuring various live and on-demand demo applications using the LOC and CMSF formats.

## moqtail-ts (MOQtail TypeScript Library)

The TypeScript client library for Media-over-QUIC (MoQ) applications, designed for seamless integration with WebTransport and MoQ relay servers.

### ✨ Features

- 🛡️ **TypeScript**: Type-safe development
- 🔗 **WebTransport**: Next-gen transport protocol support
- 🔥 **Hot Module Reloading**: Instant feedback during development

README available at: [moqtail-ts/README.md](libs/moqtail-ts/README.md)

## 🚀 Getting Started

### Prerequisites

- [Node.js](https://nodejs.org/) (v18+ recommended)
- [npm](https://www.npmjs.com/)

### Installation

```bash
# Clone the repository (if not already)
git clone https://github.com/moqtail/moqtail.git
cd moqtail

# Install dependencies
npm install
```

## moqtail-rs (MOQtail Rust Library)

The Rust library for Media-over-QUIC (MoQ) applications, providing core protocol functionalities and utilities.

## Relay

The relay is a Rust application that forwards MoQ messages between publishers and subscribers.

```bash
cargo run --bin relay -- --port 4433 --cert-file cert/cert.pem --key-file cert/key.pem
```

## Docker Deployment

The Docker image manages TLS certificates via Cloudflare R2 and BunnyCDN DNS, removing the need to manage certs manually.

### How the entrypoint works

1. **DNS update** — fetches the BunnyCDN Anycast IP and updates the A record for your subdomain
2. **R2 download** — downloads TLS certificates directly from Cloudflare R2 via rclone (no FUSE required)
3. **Cert renewal** — runs certbot (dns-bunny plugin) if the cert is missing or expiring within 30 days; writes renewed certs back to R2
4. **Relay start** — launches `relay` with the cert paths

Certs are stored in R2 under `${R2_PREFIX}/fullchain.pem`.

### Requirements

- R2 bucket and API credentials (see Cloudflare dashboard)
- BunnyCDN API key with DNS zone access

### Running

```bash
docker compose up --build
```

### Environment Variables

**Required**

| Variable | Description |
|---|---|
| `S3_ENDPOINT` | S3-compatible endpoint URL (e.g. `https://<id>.r2.cloudflarestorage.com`) |
| `S3_ACCESS_KEY_ID` | S3 API token access key |
| `S3_SECRET_ACCESS_KEY` | S3 API token secret |
| `S3_BUCKET_NAME` | S3 bucket name |
| `S3_PREFIX` | Subdirectory prefix within the bucket |
| `BUNNY_APIKEY` | BunnyCDN API key |
| `BUNNY_APP_ID` | Magic Containers app ID |
| `BUNNY_ZONEID` | DNS zone ID |
| `BUNNY_RECORDID` | DNS record ID to update |
| `DNS_SUBDOMAIN` | Subdomain name for the A record |
| `CERTBOT_DOMAIN` | Domain for cert issuance |
| `CERTBOT_EMAIL` | Let's Encrypt contact email |

**Optional**

| Variable | Default | Description |
|---|---|---|
| `S3_PROVIDER` | `Other` | rclone S3 provider (e.g. `Cloudflare`, `AWS`, `Minio`) |
| `S3_CERT_FILE` | `fullchain.pem` | Cert filename in the bucket |
| `S3_KEY_FILE` | `privkey.pem` | Key filename in the bucket |
| `CERTBOT_STAGING` | — | Use LE staging if set |
| `RELAY_PORT` | `443` | UDP port |
| `RELAY_HOST` | `::` | Bind host |

## 🤝 Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements, bug fixes, or documentation updates.
