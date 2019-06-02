#!/usr/bin/env bash

# install nix
# this depends on os, if we are on nix-os, this is not required
[ ! -d /nix ] && curl https://nixos.org/nix/install | sh

source "$HOME/.nix-profile/etc/profile.d/nix.sh"

isDarwin =  $(nix-instantiate --eval --expr '((import <nixpkgs>) {}).stdenv.isDarwin')
if [ "$isDarwin" = "true" ]; then
    echo "Its Darwin!"
fi


