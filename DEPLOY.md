# Deploy (Docker + Traefik)

The production stack runs the app via Gunicorn behind Nginx, with Traefik handling TLS and routing.

## Prerequisites

- Docker and Docker Compose installed on the server
- A Traefik reverse proxy running on the `otobonik_net` Docker network
- An external Docker volume: `otobonik_website_static`

Create the volume once if it doesn't exist:

```bash
docker volume create --name=otobonik_website_static
```

## Build

```bash
make build
```

## Start

```bash
make up
```

To build and start in one step:

```bash
make up BUILD=1
```

## Other commands

| Command | Description |
|---|---|
| `make stop` | Stop all services |
| `make down` | Stop and remove containers |
| `make restart` | Restart services |
| `make restart BUILD=1` | Rebuild image then restart |
| `make logs` | Tail logs for all services |
| `make logs SERVICE=otobonik-website` | Tail logs for a specific service |
| `make flush-static` | Recreate the static files volume |
