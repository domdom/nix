{pkgs, ...}:

{
  home.packages = with pkgs; [
    ccache
  ];

  home.file.".ccache/ccache.conf".source = ./ccache.conf;
}
