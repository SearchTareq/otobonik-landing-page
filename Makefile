SHELL := /bin/bash

COMPOSE := docker compose -f docker-compose.website.yml
IMAGE   := otobonik-website:latest

.PHONY: help build up stop down restart rm logs flush-static

help:
	@echo "Usage:"
	@echo "  make build                  Build the website Docker image"
	@echo "  make up [BUILD=1]           Start all services (optionally rebuild first)"
	@echo "  make stop                   Stop all services"
	@echo "  make down                   Stop and remove containers"
	@echo "  make restart [BUILD=1]      Restart services (optionally rebuild first)"
	@echo "  make rm                     Remove stopped containers"
	@echo "  make logs [SERVICE=<name>]  Tail logs (all or a specific service)"
	@echo "  make flush-static           Recreate the otobonik_website_static volume"

build:
	@echo "Building website image..."
	@docker build -f Dockerfile -t $(IMAGE) .

up:
	@if [ "$(BUILD)" = "1" ]; then \
		$(MAKE) build; \
	fi
	@echo "Starting website stack..."
	@$(COMPOSE) up -d

stop:
	@echo "Stopping website stack..."
	@$(COMPOSE) stop

down:
	@echo "Bringing down website stack..."
	@$(COMPOSE) down

restart:
	@$(MAKE) stop
	@$(MAKE) up BUILD=$(BUILD)

rm:
	@echo "Removing website containers..."
	@$(COMPOSE) rm -f

logs:
	@if [ -n "$(SERVICE)" ]; then \
		$(COMPOSE) logs -f $(SERVICE); \
	else \
		$(COMPOSE) logs -f; \
	fi

flush-static:
	@docker volume rm otobonik_website_static || true
	@docker volume create --name=otobonik_website_static
