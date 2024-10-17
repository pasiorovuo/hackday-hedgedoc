#!/bin/sh

# Create user and database for Hedgedoc
createuser "${HEDGEDOC_USER}"
createdb --owner "${HEDGEDOC_USER}" "${HEDGEDOC_DB}"
psql -c "ALTER USER ${HEDGEDOC_USER} WITH PASSWORD '${HEDGEDOC_PASSWORD}'"

# Create user and database for GhostWriter
createuser "${GHOSTWRITER_USER}"
createdb --owner "${GHOSTWRITER_USER}" "${GHOSTWRITER_DB}"
psql -c "ALTER USER ${GHOSTWRITER_USER} WITH PASSWORD '${GHOSTWRITER_PASSWORD}'"
