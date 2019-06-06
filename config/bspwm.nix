{pkgs, lib}:

let

  de = lib.writeScriptBin "de" ''
    
    '';

in
  {
    home.packages = with pkgs; [
      bspwm     # window manager
      sxhkd     # hotkeys
      lemonbar  # status bar
    ];


  }
