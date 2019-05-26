{config, pkgs, ...}:

let
  settings = (import ./shell.nix) { config = config; };
in
  {
    programs.fish = {
      enable = true;
      shellAliases = settings.aliases;
    };
  }
