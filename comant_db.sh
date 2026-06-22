#!/bin/bash
set -euo pipefail

docker compose exec web odoo -i base -d odoo --stop-after-init --db_host=db -r odoo -w odoo
