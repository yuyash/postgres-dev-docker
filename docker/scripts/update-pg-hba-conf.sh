#!/bin/bash
PG_HBA_CONF_FILE="${PG_DIR_PREFIX}/data/pg_hba.conf"
cp "${PG_HBA_CONF_FILE}" "${PG_HBA_CONF_FILE}.bak"
sed -i "s|^host\s\+all\s\+all\s\+127.0.0.1\/32\s\+scram-sha-256|host all all 127.0.0.1/32 trust\nhost all all 0.0.0.0/0 scram-sha-256|" "${PG_HBA_CONF_FILE}"
echo "Updated pg_hba.conf:"
cat "${PG_HBA_CONF_FILE}"