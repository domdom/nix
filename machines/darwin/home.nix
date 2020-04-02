{ pkgs, ... }:

{
  imports = [
    ../../config/unix-base.nix
  ];

  programs.bash = {
    enable = true;
    bashrcExtra = ''
      [ -f "$HOME/.bashrc_local" ] && source "$HOME/.bashrc_local"
      if [[ $- == *i* ]]; then
        exec fish
      fi
    '';
  };
}
