{ pkgs, ... }:

{
  imports = [
    ../config/unix-base.nix
    ../config/git.nix
    ../config/kak.nix
    ../config/fzf.nix
  ];
  xdg.enable = true;
}
