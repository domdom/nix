{ pkgs, ... }:

{
  imports = [
    ../config/unix-base.nix

    ../config/git.nix
    ../config/kak.nix
    ../config/fzf.nix

    ../config/fish.nix
    ../config/alacritty.nix
  ];
  xdg.enable = true;
}
