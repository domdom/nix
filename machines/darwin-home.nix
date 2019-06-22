{ pkgs, ... }:

{
  imports = [
    ../config/unix-base.nix

    ../config/kak.nix
    ../config/git.nix
    ../config/fzf.nix
    ../config/git-fzf.nix

    ../config/nvim.nix

    ../config/fish.nix
    ../config/alacritty.nix
  ];
  xdg.enable = true;
}
