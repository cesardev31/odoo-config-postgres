# Odoo 19 local con Docker Compose y PostgreSQL

Este proyecto levanta Odoo 19 con PostgreSQL local para desarrollo y pruebas de integración.

## Servicios

- `web`: Odoo 19 en `http://localhost:8069`
- `db`: PostgreSQL 16 interno, sin exponer puerto al host

## Archivos

```txt
.
├── docker-compose.yml
├── config/
│   └── odoo.conf
├── addons/
└── comant_db.sh
```

## Comandos

```bash
docker compose up -d
docker compose ps
docker compose logs -f web
docker compose down
```

## Configuracion actual

PostgreSQL corre en la red interna de Docker:

- Host: `db`
- Puerto: `5432`
- Usuario: `odoo`
- Password: `odoo`

Odoo usa `config/odoo.conf`. El `admin_passwd` es la clave maestra para crear o administrar bases desde la pantalla de base de datos de Odoo.

## Crear base inicial por consola

```bash
./comant_db.sh
```

El script crea una base llamada `odoo` e instala el modulo `base`. Si ya creaste una base desde la UI, no necesitas ejecutarlo.

## Conectar Orvix con este Odoo local

En Orvix, Ajustes -> Integraciones -> Odoo ERP:

- URL: `http://localhost:8069`
- Base de datos: la base creada en Odoo, por ejemplo `orvixapp`
- Usuario: el correo/usuario de Odoo
- Password/API key: la clave del usuario de Odoo

Para desarrollo local en otra app Docker, usa la IP del host o publica Odoo en una red compartida; `localhost` solo funciona desde el host.
