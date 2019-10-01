{ pkgs, ... }:

{
  imports = [
    ../../config/unix-base.nix

    ../../config/kak.nix
    ../../config/git.nix
    ../../config/fzf.nix
    ../../config/git-fzf.nix

    ../../config/fish.nix
    ../../config/nvim

    ../../config/bat.nix
    # terminal
    ../../config/alacritty.nix
  ];
  xdg.enable = true;
}
