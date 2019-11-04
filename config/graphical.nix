{pkgs, ...}:

{
  imports = [
    ./bspwm
  ];

  home.packages = with pkgs; [
    termite
    dmenu
  ];

  home.sessionVariables = {
    TERMINAL = "gnome-terminal";
  };
}
