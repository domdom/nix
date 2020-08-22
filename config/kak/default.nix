{pkgs, config, ...}:

{
  home.packages = [ pkgs.kakoune ];

  xdg.configFile."kak/kakrc".source = config.lib.file.mkOutOfStoreSymlink ./kakrc;
 
  home.sessionVariables = {
    EDITOR = "kak";
  };
}
