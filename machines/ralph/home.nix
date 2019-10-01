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

    ../../config/ccache.nix
    # graphical stuff?
    # bspwm etc
  ];
  xdg.enable = true;

  home.sessionVariables = {
    LOCALE_ARCHIVE_2_27 = "${pkgs.glibcLocales}/lib/locale/locale-archive";
    # Trick to get java applications to render properly in BSPWM
    # https://wiki.archlinux.org/index.php/Java#Non-reparenting_window_managers_/_Grey_window_/_Programs_not_drawing_properly
    _JAVA_AWT_WM_NONREPARENTING = 1;
  };
}
