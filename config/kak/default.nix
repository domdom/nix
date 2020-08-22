{pkgs, config, ...}:

{
  programs.kakoune = {
    enable = true;
    extraConfig = builtins.readFile ./kakrc;
    #plugins = with pkgs; [
      #kakounePlugins.fzf-kak
    #];
  };
  home.sessionVariables = {
    EDITOR = "kak";
  };
}
