#!/usr/bin/env bash

set -u

echo "Running diagnostic health check..."

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DIAGNOSTIC_SCRIPT="$SCRIPT_DIR/diagnostic.sh"

if ! command -v bash >/dev/null 2>&1; then
    echo "FAIL: bash is not available."
    exit 1
fi

if ! command -v df >/dev/null 2>&1; then
    echo "FAIL: df is not available."
    exit 1
fi

if ! command -v ping >/dev/null 2>&1; then
    echo "FAIL: ping is not available."
    exit 1
fi

if [[ ! -x "$DIAGNOSTIC_SCRIPT" ]]; then
    echo "FAIL: diagnostic.sh is missing or not executable."
    exit 1
fi

echo "PASS: required tools are available."
echo "PASS: diagnostic CLI is available."
echo "Health check successful."

exit 0