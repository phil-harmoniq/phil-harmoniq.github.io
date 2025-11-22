#!/usr/bin/env bash

set -euo pipefail
# script_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
base_url="https://raw.githubusercontent.com/phil-harmoniq/hosts/refs/heads/main/rpi"

main()
{
    add_shell_config
    install_packages
    enable_services
    configure_podman
}

add_shell_config()
{
    tmp_dir="/tmp/hosts/rpi"

    echo "Downloading shell config to $tmp_dir"
    mkdir -p "$tmp_dir/shell/.bashrc.d"

    curl "$base_url/shell/.bashrc.d/aliases" > "$tmp_dir/shell/.bashrc.d/aliases"
    curl "$base_url/shell/.bashrc.d/prompt" > "$tmp_dir/shell/.bashrc.d/prompt"
    curl "$base_url/shell/.inputrc" > "$tmp_dir/shell/.inputrc"

    echo "Adding shell config to current user"
    mkdir -p "$HOME/.bashrc.d/"
    cp "$tmp_dir/shell/.bashrc.d/aliases" "$DEST_BASH_CONFIG_DIR"
    cp "$tmp_dir/shell/.bashrc.d/prompt" "$DEST_BASH_CONFIG_DIR"
    cp "$tmp_dir/shell/.inputrc" "$HOME"
}

install_packages()
{
    dnf install epel-release -y
    dnf install \
        podman \
        git \
        btop \
        tldr \
        shellcheck \
        fastfetch \
        cockpit \
        cockpit-files \
        cockpit-podman \
        cockpit-storaged \
        samba \
        samba-client \
        cifs-utils \
        -y
}

enable_services()
{
    systemctl enable --now cockpit
}

configure_podman()
{
    loginctl enable-linger devops
}

main
