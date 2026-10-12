#!/usr/bin/env bash

set -u

show_help() {
    echo "Diagnostic CLI"
    echo
    echo "Usage:"
    echo "  diagnostic system"
    echo "  diagnostic network <host>"
    echo "  diagnostic disk"
    echo "  diagnostic help"
    echo
    echo "Commands:"
    echo "  system              Display system information"
    echo "  network <host>      Check the supplied host"
    echo "  disk                Display disk information"
    echo "  help                Display this help message"
}

system_check() {
    echo "======================================"
    echo "        SYSTEM DIAGNOSTIC"
    echo "======================================"
    echo "Hostname: $(hostname)"
    echo "User: $(whoami)"
    echo "Operating System: $(uname -s)"
    echo "Kernel: $(uname -r)"
    echo "Architecture: $(uname -m)"
    echo "Uptime: $(uptime)"

    echo
    echo "CPU Information:"
    if command -v nproc >/dev/null 2>&1; then
        echo "CPU Cores: $(nproc)"
    else
        echo "CPU Cores: unavailable"
    fi

    echo
    echo "Memory Information:"
    if command -v free >/dev/null 2>&1; then
        free -h
    else
        echo "Memory information unavailable."
    fi

    echo
    echo "======================================"
}

network_check() {
    local host="$1"

    echo "======================================"
    echo "        NETWORK DIAGNOSTIC"
    echo "======================================"
    echo "Host: $host"

    local address

if command -v getent >/dev/null 2>&1; then
    address=$(getent hosts "$host" 2>/dev/null | awk 'NR==1 {print $1}')
elif command -v dscacheutil >/dev/null 2>&1; then
    address=$(dscacheutil -q host -a name "$host" 2>/dev/null \
        | awk '/^ip_address:/ {print $2; exit}')
else
    echo "Error: no supported hostname resolution command is available."
    return 1
fi

    if [[ -z "$address" ]]; then
        echo "Error: unable to resolve host: $host"
        return 1
    fi

    echo "Resolved Address: $address"

    echo
    echo "Connectivity Check:"

    if ping -c 1 -W 2 "$host" >/dev/null 2>&1; then
        echo "Status: Reachable"
    else
        echo "Status: Unreachable"
        return 1
    fi

    echo "======================================"
}

disk_check() {
    echo "======================================"
    echo "          DISK DIAGNOSTIC"
    echo "======================================"

    df -h /

    echo "======================================"
}

if [[ $# -eq 0 ]]; then
    echo "Error: no command supplied."
    echo
    show_help
    exit 2
fi

command="$1"

case "$command" in
    system)
        [[ $# -eq 1 ]] || {
            echo "Error: system does not accept additional arguments."
            exit 2
        }
        system_check
        ;;

    network)
        if [[ $# -ne 2 ]]; then
            echo "Error: network requires a hostname or IP address."
            echo "Usage: diagnostic network <host>"
            exit 2
        fi

        network_check "$2"
        ;;

    disk)
        [[ $# -eq 1 ]] || {
            echo "Error: disk does not accept additional arguments."
            exit 2
        }
        disk_check
        ;;

    help)
        [[ $# -eq 1 ]] || {
            echo "Error: help does not accept additional arguments."
            exit 2
        }
        show_help
        ;;

    *)
        echo "Error: invalid command: $command"
        echo
        show_help
        exit 2
        ;;
esac
