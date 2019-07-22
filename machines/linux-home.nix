{ pkgs, ... }:

{
  imports = [
    ../config/unix-base.nix

    ../config/kak.nix
    ../config/git.nix
    ../config/fzf.nix
    ../config/git-fzf.nix

    ../config/fish.nix
    ../config/nvim

    ../config/bat.nix
    # graphical stuff?
    # bspwm etc
  ];
  xdg.enable = true;

  home.sessionVariables = {
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
  };
}
