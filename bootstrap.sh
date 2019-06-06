#!/usr/bin/env bash

# install nix
# this depends on os, if we are on nix-os, this is not required
[ ! -d /nix ] && curl https://nixos.org/nix/install | sh

source "$HOME/.nix-profile/etc/profile.d/nix.sh"

mkdir -p "$HOME/.config/nixpkgs"

host=$(nix-instantiate --eval host.nix | xargs echo)

ln -srf machines/$host-config.nix "$HOME/.config/nixpkgs/config.nix"
ln -srf machines/$host-home.nix "$HOME/.config/nixpkgs/home.nix"
#nix-shell -v -p home-manager --run "home-manager switch"
