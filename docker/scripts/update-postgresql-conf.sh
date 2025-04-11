#!/bin/bash
POSTGRESQL_CONF_FILE="${PG_DIR_PREFIX}/data/postgresql.conf"
cp "${POSTGRESQL_CONF_FILE}" "${POSTGRESQL_CONF_FILE}.bak"
sed -i "s|^#listen_addresses\s\+=\s\+'localhost'|listen_addresses = '*'|" "${POSTGRESQL_CONF_FILE}"
echo "Updated postgresql.conf:"
cat "${POSTGRESQL_CONF_FILE}"