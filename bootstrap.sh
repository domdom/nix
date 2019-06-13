#!/usr/bin/env bash

# install nix
# this depends on os, if we are on nix-os, this is not required
[ ! -d /nix ] && sh <(curl https://nixos.org/nix/install) --daemon

mkdir -p "$HOME/.config/nixpkgs"

prefix=${1}

config="machines/$prefix-config.nix"
if [ -e "$config" ]; then
    ln -sf "$(realpath "$config")" "$HOME/.config/nixpkgs/config.nix"
fi

home="machines/$prefix-home.nix"
if [ -e "$home" ]; then
    ln -sf "$(realpath "$home")" "$HOME/.config/nixpkgs/home.nix"
else
    echo "'$home' does not exist!"
    exit 1
fi

nix-shell -v -p home-manager --run "home-manager switch"
