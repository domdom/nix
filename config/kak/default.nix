{pkgs, config, ...}:

{
  home.packages = [
    pkgs.kakoune
    pkgs.kak-lsp
  ];

  xdg.configFile."kak/kakrc".source = config.lib.file.mkOutOfStoreSymlink ./kakrc;
 
  home.sessionVariables = {
    EDITOR = "kak";
  };
}
