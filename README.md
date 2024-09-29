# news

## Prerequisite

- Flutter
- Node.js 20
- pnpm

```sh
# Install pnpm
curl -fsSL https://get.pnpm.io/install.sh | sh -
```

## How to run (server)

```sh
cd server
cp .env.example .env # change environment variables
pnpm install
pnpm setup:db
pnpm start  # Check localhost:3000
```
