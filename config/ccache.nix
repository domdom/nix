{config, pkgs, ...}:

let
  ccache = pkgs.callPackage ./ccache {};
in
  {
    home.packages = [
      ccache
    ];

    home.file.".ccache/ccache.conf".text = ''
      debug     = true
      cache_dir = $HOME/data/ccache
      log_file  = $PWD/log
      max_size  = 300G
    '';
  }
