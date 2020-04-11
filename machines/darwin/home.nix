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

  home.sessionVariables = {
    LOCALE_ARCHIVE = "${pkgs.darwin.locale}/lib/locale/locale-archive";
    LOCALE_ARCHIVE_2_27 = "${pkgs.darwin.locale}/lib/locale/locale-archive";
  };
}
