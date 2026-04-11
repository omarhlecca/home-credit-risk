.PHONY: help setup up down logs test

help:
	@echo "Comandos disponibles:"
	@echo "  make setup   — Copiar .env.example a .env"
	@echo "  make up      — Levantar todos los servicios Docker"
	@echo "  make down    — Bajar todos los servicios"
	@echo "  make logs    — Ver logs de todos los servicios"
	@echo "  make test    — Ejecutar tests unitarios"

setup:
	cp .env.example .env
	@echo ".env creado. Edita los valores antes de ejecutar make up"

up:
	docker compose -f docker/docker-compose.yml up -d

down:
	docker compose -f docker/docker-compose.yml down

logs:
	docker compose -f docker/docker-compose.yml logs -f

test:
	pytest tests/ -v