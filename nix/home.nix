{ pkgs, ... }:

{
  imports = [
    ../cfg/unix-base.nix
    ../cfg/git.nix
    ../cfg/kak.nix
    ../cfg/fish.nix
  ];
  xdg.enable = true;
}
