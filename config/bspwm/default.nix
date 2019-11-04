{pkgs, lib, ...}:

let
  MOD_KEY = "alt";
in
  {
    home.packages = with pkgs; [
      bspwm     # window manager
      sxhkd     # hotkeys
      #lemonbar  # status bar
      (pkgs.writeScriptBin "de" (builtins.readFile ./de))
      (pkgs.writeScriptBin "de-switch" ''
        #!/usr/bin/env bash
        de last $(de workspaces | ${pkgs.dmenu}/bin/dmenu)
      '')
    ];

    xdg.configFile."bspwm/bspwmrc".text = ''
      #!/bin/sh

      bspc config border_width        3
      bspc config window_gap          20
      bspc config top_padding         0
      bspc config left_padding        0
      bspc config right_padding       0
      bspc config bottom_padding      0

      bspc config split_ratio             0.50
      bspc config initial_polarity        second_child
      bspc config borderless_monocle      true
      bspc config gapless_monocle         true
      bspc config focus_follows_pointer   true
      bspc config pointer_follows_focus   false
      bspc config click_to_focus          true
      bspc config ignore_ewmh_focus       true

      bspc config pointer_modifier mod1

      bspc config remove_disabled_monitors true
      bspc config remove_unplugged_monitors true

      bspc config normal_border_color '#000000'
      #bspc config focused_border_color '#525252'
      bspc config focused_border_color '#77dd77'
      #bspc config focused_border_color '#59d2ff'
      bspc config presel_feedback_color '#afcce0'

      $HOME/bin/de init $HOME/.config/bspwm/config.json | sh

      ############################################
      # Startup stuff
      ############################################
      # key repeat rate
      xset r rate 200 50
      # set cursor for root window
      xsetroot -cursor_name left_ptr
      hsetroot -solid '#404040'

      #### Additional programs
      kill $(pidof sxhkd)
      sxhkd &

      killall compton
      compton --backend glx --unredir-if-possible --vsync opengl-swc --config $HOME/.config/compton.conf &

      killall tint2
      tint2 &
    '';
    xdg.configFile."bspwm/bspwmrc".executable = true;

    services.sxhkd = {
      enable = true;
      keybindings = {
        # Focus nodes in desktop
        "${MOD_KEY} + {_,shift + }{j,k,h,l}"   = "bspc node -{f,s} {south,north,west,east}";
        "${MOD_KEY} + {_,shift + } Tab"        = "bspc node -f {next,prev}.local";
        # focus the next/previous desktop
        #"ctrl + alt + {h,l,j,k}"               = "bspc desktop $(de {left,right,down,up}) -f";
        # move node to next/previous desktop
        #"ctrl + alt + shift + {h,l,j,k}"       = "bspc node -d $(de {left,right,down,up}) -f";

        # TODO implement this nicely
        # Switch workspace
        #"alt + g"                              = "bspc desktop $(de-switch) -f";
        "${MOD_KEY} + w"                       = "bspc desktop $(de-switch) -f";
        "${MOD_KEY} + shift + w"               = "bspc node -d $(de-switch)";

        # focus to the given desktop
        "${MOD_KEY} + {1-9}"                   = "bspc desktop $(de nth {1-9}) -f";
        "${MOD_KEY} + shift + {1-9}"           = "bspc node -d $(de nth {1-9})";
        "super + g"                            = "bspc config window_gap $(( $(bspc config window_gap) ? 0 : 20 ))";

        # Switching with multiple monitors
        # "super + alt + {h,l}"                  = "bspc monitor -f {prev,next}";

        # terminal emulator
        "${MOD_KEY} + Return"                  = "$TERMINAL";
        # program launcher
        "${MOD_KEY} + space"                   = "dmenu_run";
        # close and kill
        "${MOD_KEY} + {_,shift + }q"           = "bspc node -{c,k}";

        # make sxhkd reload its configuration files:
        "${MOD_KEY} + Escape"                  = "bash $HOME/.config/bspwm/bspwmrc";
        # quit bspwm normally
        "super + alt + Escape"                 = "bspc quit";
        # set the window state
        "super + {y,p,shift + f,f}"            = "bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";
        # set the node flags
        "super + ctrl + {a,o,e}"               = "bspc node -g {locked,sticky,private}";

        #
        # preselect
        #

        # preselect the direction
        "super + shift + {h,j,k,l}"           = "bspc node -p {west,south,north,east}";

        # cancel the preselection for the focused node
        "super + shift + space"               = "bspc node -p cancel";

        # move focused node into preselected space
        "super + shift + Return"              = "bspc node -n 'last.!automatic.local'";

        # cancel the preselection for the focused desktop
        "super + ctrl + shift + space"        = "bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel";
      };
    };
  }
