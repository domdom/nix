{ pkgs, ... }:

{
  imports = [
    ./base-home.nix

    # graphical stuff?
  ];
  xdg.enable = true;

  home.sessionVariables = {
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };
}
