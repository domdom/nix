{config, pkgs, ...}:

{
  home.packages = with pkgs; [
    ccache
  ];

  xdg.configFile."ccache/config".text = ''
      cache_dir = ${config.home.homeDirectory}/data/ccache
      max_size  = 100G
  '';

  home.sessionVariables = {
    CCACHE_CONFIGPATH="${config.xdg.configHome}/ccache/config";
  };
}
