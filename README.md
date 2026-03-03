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

Certs are stored in R2 under `${R2_PREFIX}/fullchain.pem` (default prefix: `$HOSTNAME`, overridden via `R2_PREFIX`).

### Requirements

- Docker host must support FUSE (`/dev/fuse` device, `SYS_ADMIN` capability)
- R2 bucket and API credentials (see Cloudflare dashboard)
- BunnyCDN API key with DNS zone access

### Running

```bash
docker compose up --build
```

### Environment Variables

| Variable | Required | Description |
|---|---|---|
| `R2_ACCOUNT_ID` | Yes | Cloudflare account ID |
| `R2_ACCESS_KEY_ID` | Yes | R2 API token access key |
| `R2_SECRET_ACCESS_KEY` | Yes | R2 API token secret |
| `R2_BUCKET_NAME` | Yes | R2 bucket name |
| `R2_PREFIX` | No | Subdir in bucket (default: `$HOSTNAME`) |
| `R2_CERT_FILE` | No | Cert filename (default: `fullchain.pem`) |
| `R2_KEY_FILE` | No | Key filename (default: `privkey.pem`) |
| `BUNNY_APIKEY` | No | BunnyCDN API key (DNS update + certbot) |
| `BUNNY_APP_ID` | No | Magic Containers app ID |
| `BUNNY_ZONEID` | No | DNS zone ID |
| `BUNNY_RECORDID` | No | DNS record ID |
| `DNS_SUBDOMAIN` | No | Subdomain for A record |
| `CERTBOT_DOMAIN` | No | Domain for cert issuance |
| `CERTBOT_EMAIL` | No | Let's Encrypt contact email |
| `CERTBOT_STAGING` | No | Use LE staging if set |
| `RELAY_PORT` | No | UDP port (default: `4433`) |
| `RELAY_HOST` | No | Bind host (default: `::`) |

## 🤝 Contributing

Contributions are welcome! Please open issues or submit pull requests for improvements, bug fixes, or documentation updates.
