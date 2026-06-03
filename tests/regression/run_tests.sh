#!/usr/bin/env bash
set -euo pipefail
TAP_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
PIP_CACHE="${HOME}/.cache/pip-tap-shopify"
mkdir -p "$PIP_CACHE"

echo "==> Running regression tests in python:3.11-slim"
docker run --rm \
  -v "$TAP_DIR":/tap \
  -v "$PIP_CACHE":/root/.cache/pip \
  -w /tap \
  -e TAP_SHOPIFY_SHOP="${TAP_SHOPIFY_SHOP:?}" \
  -e TAP_SHOPIFY_API_KEY="${TAP_SHOPIFY_API_KEY:?}" \
  -e TAP_SHOPIFY_INCLUDE_STREAMS="${TAP_SHOPIFY_INCLUDE_STREAMS:-locations,custom_collections}" \
  -e TAP_SHOPIFY_START_DATE="${TAP_SHOPIFY_START_DATE:-2024-01-01T00:00:00Z}" \
  -e AES_SECRET_KEY="peliqan-test-key" \
  python:3.11-slim \
  bash -c "
    apt-get update -qq && apt-get install -y -qq git build-essential > /dev/null
    python -m venv /venv
    /venv/bin/pip install -e . pytest
    cd tests/regression && /venv/bin/python -m pytest test_regression.py -v
  "
