#!/usr/bin/env bash

set -u

PASS=0
FAIL=0

pass() {
    echo "PASS: $1"
    PASS=$((PASS + 1))
}

fail() {
    echo "FAIL: $1"
    FAIL=$((FAIL + 1))
}

echo "======================================"
echo " Assignment 2 - Diagnostic CLI Tests"
echo "======================================"
echo

# Build image
if docker build -t diagnostic-tool . >/dev/null 2>&1; then
    pass "Docker image builds successfully"
else
    fail "Docker image failed to build"
fi

# Help
if docker run --rm diagnostic-tool help >/dev/null 2>&1; then
    pass "diagnostic help works"
else
    fail "diagnostic help failed"
fi

# System
if docker run --rm diagnostic-tool system >/dev/null 2>&1; then
    pass "diagnostic system works"
else
    fail "diagnostic system failed"
fi

# Disk
if docker run --rm diagnostic-tool disk >/dev/null 2>&1; then
    pass "diagnostic disk works"
else
    fail "diagnostic disk failed"
fi

# Network
if docker run --rm diagnostic-tool network localhost >/dev/null 2>&1; then
    pass "diagnostic network works"
else
    fail "diagnostic network failed"
fi

# Invalid command
docker run --rm diagnostic-tool invalid-command >/dev/null 2>&1
if [[ $? -eq 2 ]]; then
    pass "Invalid command returns exit code 2"
else
    fail "Invalid command did not return exit code 2"
fi

# Health check
if docker run --rm --entrypoint /app/health-check.sh diagnostic-tool >/dev/null 2>&1; then
    pass "Health check works"
else
    fail "Health check failed"
fi

echo
echo "======================================"
echo "Passed: $PASS"
echo "Failed: $FAIL"
echo "======================================"

if [[ $FAIL -eq 0 ]]; then
    exit 0
else
    exit 1
fi