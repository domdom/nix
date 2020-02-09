{pkgs, config, lib, ...}:

{
  home.packages = with pkgs; [
    gnupg
    pass
  ];

  home.sessionVariables = {
    PASSWORD_STORE_DIR="${config.xdg.dataHome}/pass";
  };
}
