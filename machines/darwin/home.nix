{ pkgs, ... }:

{
  imports = [
    ../../config/unix-base.nix
    # terminal
    ../../config/alacritty.nix
  ];
  xdg.enable = true;
}
