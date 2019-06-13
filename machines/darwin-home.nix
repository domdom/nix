{ pkgs, ... }:

{
  imports = [
    ./base-home.nix

    ../config/alacritty.nix
  ];
  xdg.enable = true;
}
