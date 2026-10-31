#!/usr/bin/env bash
set -euo pipefail

{
  curl -fsSL https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
  curl -fsSL https://github.com/oiyay/Youtube_BlockAds_List/raw/refs/heads/main/blocklist.txt
} | tr -d '\r' \
  | sed 's/#.*//' \
  | awk 'NF { print tolower($NF) }' \
  | grep -Ev '^(localhost|localhost\.localdomain|local|broadcasthost|ip6-.*|0\.0\.0\.0|127\.0\.0\.1|::1)$' \
  | grep -E '^[a-z0-9._-]+\.[a-z0-9-]+$' \
  | sort -u \
  | sed 's/^/0.0.0.0 /' > blocklist.txt

wc -l blocklist.txt && ls -lh blocklist.txt
