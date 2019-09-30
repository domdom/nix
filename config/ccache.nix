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
      cache_dir = ${config.home.homeDirectory}/data/ccache
      max_size  = 300G
    '';
  }
