{pkgs, config, lib, ...}:

{
  home.packages = with pkgs; [
    pass
  ];

  home.sessionVariables = {
    PASSWORD_STORE_DIR="${config.xdg.dataHome}/pass"
  };
}
