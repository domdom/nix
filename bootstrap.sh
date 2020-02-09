#!/usr/bin/env bash

# install nix
# this depends on os, if we are on nix-os, this is not required
[ ! -d /nix -o ! "$(ls /nix)" ] && sh <(curl https://nixos.org/nix/install) --daemon && echo "You should reboot now"

mkdir -p "$HOME/.config/nixpkgs"

# Should reboot here

prefix=${1:-$(hostname)}

config="$HOME/nix/machines/$prefix/config.nix"
if [ -e "$config" ]; then
    ln -sf "$config" "$HOME/.config/nixpkgs/config.nix"
fi

home="$HOME/nix/machines/$prefix/home.nix"
if [ -e "$home" ]; then
    ln -sf "$home" "$HOME/.config/nixpkgs/home.nix"
else
    echo "'$home' does not exist!"
    exit 1
fi

export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH

nix-shell -v -p home-manager --run "home-manager switch"
#nix-shell '<home-manager>' -A install
