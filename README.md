# Despliegue de Odoo 17 con Docker Compose y PostgreSQL

Esta guía te ayudará a desplegar Odoo 17 usando Docker Compose junto con PostgreSQL de manera sencilla y estructurada.

## 📋 Prerrequisitos

- Docker instalado
- Docker Compose instalado
- Git (opcional)
- Acceso root o sudo en el servidor

## 🚀 Estructura del Proyecto

```
odoo-docker/
├── docker-compose.yml
├── config/
│   └── odoo.conf
├── addons/
└── scripts/
    └── command_db.sh
```

## 📝 Configuración

### 1. Docker Compose

Crear el archivo `docker-compose.yml`:

```yaml
version: '3.1'
services:
  web:
    image: odoo:17.0
    ports:
      - "8069:8069"
    volumes:
      - odoo-web-data:/var/lib/odoo
      - ./config:/etc/odoo
      - ./addons:/mnt/extra-addons
    environment:
      - HOST="127.X.X.X" # IP DEL SERVIDOR
      - PORT=5432        # PUERTO DE LA BASE DE DATOS
      - USER="myuser"    # NOMBRE DE USUARIO DE LA BASE DE DATOS
      - PASSWORD="myPassword" # CONTRASEÑA DE LA BASE DE DATOS
      - DATABASE=odoo    # NOMBRE DE LA BASE DE DATOS
    command: -- --config=/etc/odoo/odoo.conf
    restart: always
volumes:
  odoo-web-data:
```

### 2. Configuración de Odoo

Crear el archivo `config/odoo.conf`:

```ini
[options]
addons_path = /mnt/extra-addons
data_dir = /var/lib/odoo
admin_passwd = myPASS    # clave del usuario de odoo por defecto
db_host = 127.x.x.x      # ip de la base de datos
db_port = 5432           # puerto de la base de datos
db_user = myuser         # usuario de la base de datos
db_password = myPASS     # contraseña de la base de datos
db_name = odoo           # nombre de la base de datos
```

### 3. Script de Inicialización de Base de Datos

Crear el archivo `scripts/command_db.sh`:

```bash
#!/bin/bash
odoo -i base -d myDbName --stop-after-init --db_host=db -r myUserdb -w myPassword
```

## 🛠️ Instalación y Despliegue

1. Clonar o crear el directorio del proyecto:
```bash
mkdir odoo-docker
cd odoo-docker
```

2. Crear los directorios necesarios:
```bash
mkdir config addons scripts
```

3. Copiar los archivos de configuración en sus respectivas ubicaciones.

4. Dar permisos de ejecución al script:
```bash
chmod +x scripts/command_db.sh
```

5. Iniciar los contenedores:
```bash
docker-compose up -d
```

## 🔍 Verificación

1. Verificar que los contenedores están corriendo:
```bash
docker-compose ps
```

2. Acceder a Odoo:
   - Abrir el navegador
   - Visitar: `http://[IP-SERVIDOR]:8069`

## 🔧 Solución de Problemas

### Si la base de datos no se conecta:

1. Entrar al contenedor:
```bash
docker-compose exec web bash
```

2. Ejecutar el script de inicialización:
```bash
./scripts/command_db.sh
```

## 📚 Comandos Útiles

```bash
# Iniciar contenedores
docker-compose up -d

# Detener contenedores
docker-compose down

# Ver logs
docker-compose logs -f web

# Reiniciar servicio
docker-compose restart web
```

## ⚠️ Consideraciones de Seguridad

1. Cambiar todas las contraseñas por defecto
2. No exponer el puerto 5432 de PostgreSQL
3. Configurar un proxy inverso con SSL
4. Mantener actualizada la imagen de Odoo

## 🆘 Soporte

Si encuentras algún problema:

1. Verificar los logs: `docker-compose logs -f`
2. Comprobar la conectividad a la base de datos
3. Verificar permisos en los volúmenes
4. Asegurarse de que los puertos no estén en uso

## 🔄 Actualizaciones

Para actualizar Odoo:

1. Modificar la versión en docker-compose.yml
2. Ejecutar:
```bash
docker-compose down
docker-compose pull
docker-compose up -d
```
