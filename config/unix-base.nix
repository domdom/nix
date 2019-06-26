{ pkgs, lib, config, ...}:

{
  home.packages = with pkgs; [
    # fzf and fd go together for use in vim and on commandline
    fzf fd
    ripgrep
    jq
    # Better userland for macOS
    coreutils
    findutils
    gawk
    gnugrep
    gnused
  ];

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };

  home.sessionVariables = {
    # Don't create 'less' history files in home dir
    LESSKEY="${config.xdg.configHome}/less/lesskey";
    LESSHISTFILE="${config.xdg.cacheHome}/less/history";

    # use less as pager
    MANPAGER="${pkgs.less}/bin/less";
  };
}
