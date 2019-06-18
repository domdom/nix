{ pkgs, ... }:

{
  imports = [
    ../config/unix-base.nix
    ../config/git.nix
    ../config/kak.nix
    ../config/fzf.nix

    ../config/fish.nix
    # graphical stuff?
    # bspwm etc
  ];
  xdg.enable = true;

  home.sessionVariables = {
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };
}
