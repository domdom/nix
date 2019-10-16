{pkgs, lib, ...}:

let

  de = pkgs.writeShellScriptBin "test_de" ''
    echo "HELLO"
    '';

  mod_key = "alt";
  bspc = with pkgs; "${bspwm}/bin/bspc";
in
  {
    home.packages = with pkgs; [
      bspwm     # window manager
      sxhkd     # hotkeys
      #lemonbar  # status bar
      de
    ];

    services.sxhkd = {
      enable = true;
      keybindings = {
        # Focus nodes in desktop
        "${mod_key} + {_,shift + }{j,k,h,l}"   = "${bspc} node -{f,s} {south,north,west,east}";
        "${mod_key} + {_,shift + } Tab"        = "${bspc} node -f {next,prev}.local";
        # focus the next/previous desktop
        "ctrl + alt + {h,l,j,k}"               = "${bspc} desktop $(${de} {left,right,down,up}) -f";
        # move node to next/previous desktop
        "ctrl + alt + shift + {h,l,j,k}"       = "${bspc} node -d $(${de} {left,right,down,up}) -f";

        # TODO implement this nicely
        # Switch workspace
        #"alt + g"                              = "${bspc} desktop $(${de}-switch) -f";

        # focus to the given desktop
        "super + {1-9}"                        = "${bspc} desktop $(${de} nth {1-9}) -f";
        "super + shift + {1-9}"                = "${bspc} node -d $(${de} nth {1-9})";
        "super + g"                            = "${bspc} config window_gap $(( $(bspc config window_gap) ? 0 : 20 ))";

        # Switching with multiple monitors
        # "super + alt + {h,l}"                  = "${bspc} monitor -f {prev,next}";

        # terminal emulator
        "${mod_key} + Return" = "gnome-terminal";

        # program launcher
        "${mod_key} + space" = "dmenu_run";

        # close and kill
        "${mod_key} + {_,shift + }q" = "${bspc} node -{c,k}";

        # make sxhkd reload its configuration files:
        "super + Escape" = "bash $HOME/.config/bspwm/bspwmrc";

        # quit bspwm normally
        "super + alt + Escape" = "bspc quit";

        # set the window state
        "super + {y,p,shift + f,f}" = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

        # set the node flags
        "super + ctrl + {a,o,e}" = "bspc node -g {locked,sticky,private}";
      };
    };
  }
