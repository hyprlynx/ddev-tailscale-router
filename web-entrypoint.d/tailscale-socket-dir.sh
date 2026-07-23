#!/usr/bin/env bash
#ddev-generated

set -euo pipefail

# tailscaled runs as the unprivileged DDEV user but its default socket path is root-owned.
readonly socket_dir=/run/tailscale

if sudo test -L "$socket_dir" || { sudo test -e "$socket_dir" && ! sudo test -d "$socket_dir"; }; then
    printf 'Refusing unsafe Tailscale runtime path: %s\n' "$socket_dir" >&2
    exit 1
fi

sudo install -d -m 0700 -o "$(id -u)" -g "$(id -g)" "$socket_dir"
