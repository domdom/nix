{pkgs, ...}:

{
  home.packages = with pkgs; [
    ccache
  ];

  home.file.".ccache/ccache.conf".text = ''
      base_dir  = $PWD
      cache_dir = $HOME/data/ccache
      max_size  = 300G
  '';
}
