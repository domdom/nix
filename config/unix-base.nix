{ pkgs, lib, config, ...}:

{
  imports = [
    ./kak.nix
    ./git.nix
    ./fzf.nix
    ./git-fzf.nix

    ./fish.nix
    ./nvim

    ./bat.nix

    ./ccache.nix
  ];

  home.packages = with pkgs; [
    # fzf and fd go together for use in vim and on commandline
    fzf fd
    # like fzf, but in rust
    skim
    ripgrep
    jq
    # Better userland for macOS
    coreutils
    findutils
    gawk
    gnugrep
    gnused
    rsync
    tree
    clang-tools
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
