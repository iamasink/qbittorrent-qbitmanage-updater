#!/usr/bin/env bash

# Exit on errors, allow unset vars if handled
set -e -o pipefail

# Timestamped logger
log() { echo "$(date '+%Y-%m-%d %H:%M:%S') [version_watcher] $*"; }

# Catch script errors
trap 'log "ERROR on line $LINENO"; exit 1' ERR

log "Starting version watcher script"

# Config
BRANCH=${QBITMANAGE_BRANCH:-master}
URL="https://raw.githubusercontent.com/StuffAnThings/qbit_manage/${BRANCH}/SUPPORTED_VERSIONS.json"
ENV_FILE=".env"
KEY="QBITTORRENT_VERSION"

# Fetch version data
log "Fetching supported versions from: $URL"
DATA=$(curl -fsSL "$URL")

# Parse and clean version
REMOTE_VER=$(echo "$DATA" | jq -r ".${BRANCH}.qbit" | sed 's/^v//')
log "Remote supported qbittorrent version: $REMOTE_VER"

# Ensure .env exists and is valid
if [[ ! -f "$ENV_FILE" ]]; then
  log ".env not found — creating with $KEY=$REMOTE_VER"
  echo "$KEY=$REMOTE_VER" > "$ENV_FILE"
  log "Script completed"
  exit 0
fi

# Read current version from .env
CURRENT=$(grep -E "^${KEY}=" "$ENV_FILE" | cut -d'=' -f2- || echo "")

if [[ -z "$CURRENT" ]]; then
  log "$KEY not set — appending $KEY=$REMOTE_VER"
  echo "$KEY=$REMOTE_VER" >> "$ENV_FILE"
elif [[ "$CURRENT" != "$REMOTE_VER" ]]; then
  log "Version mismatch: $CURRENT → $REMOTE_VER — updating"

  sed -E "s/^${KEY}=.*/${KEY}=${REMOTE_VER}/" "$ENV_FILE" > "${ENV_FILE}.tmp" && \
  cat "${ENV_FILE}.tmp" > "$ENV_FILE" && \
  rm "${ENV_FILE}.tmp"


else
  log "Version already up-to-date: $CURRENT"
fi

log "Script completed"
