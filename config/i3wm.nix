{ pkgs, lib, config, ... }:

{
  imports = [
    ./qutebrowser.nix
    ./firefox.nix
    ./termite.nix
    ./urxvt.nix
    ./st.nix
    ./kitty.nix
  ];

  home.packages = with pkgs; [
    dmenu
    xorg.xset
    xorg.xsetroot
    xorg.xinit
    hsetroot
    picom
    libnotify
  ];

  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Iosevka Term 11";
        markup = true;
        plain_text = false;
        format = "<b>%s</b>\n%b";
        sort = false;
        # Show how many messages are currently hidden (because of geometry).
        indicate_hidden = true;

        # Alignment of message text.
        # Possible values are "left", "center" and "right".
        alignment = "left";

        # The frequency with wich text that is longer than the notification
        # window allows bounces back and forth.
        # This option conflicts with "word_wrap".
        # Set to 0 to disable.
        bounce_freq = 0;

        # Show age of message if message is older than show_age_threshold
        # seconds.
        # Set to -1 to disable.
        show_age_threshold = -1;

        # Split notifications into multiple lines if they don't fit into
        # geometry.
        word_wrap = true;

        # Ignore newlines '\n' in notifications.
        ignore_newline = false;

        # Hide duplicate's count and stack them
        stack_duplicates = true;
        hide_duplicates_count = true;


        # The geometry of the window:
        #   [{width}]x{height}[+/-{x}+/-{y}]
        # The geometry of the message window.
        # The height is measured in number of notifications everything else
        # in pixels.  If the width is omitted but the height is given
        # ("-geometry x2"), the message window expands over the whole screen
        # (dmenu-like).  If width is 0, the window expands to the longest
        # message displayed.  A positive x is measured from the left, a
        # negative from the right side of the screen.  Y is measured from
        # the top and down respectevly.
        # The width can be negative.  In this case the actual width is the
        # screen width minus the width defined in within the geometry option.
        #geometry = "250x50-40+40"
        geometry = "700x80-15+49";

        # Shrink window if it's smaller than the width.  Will be ignored if
        # width is 0.
        shrink = false;

        # The transparency of the window.  Range: [0; 100].
        # This option will only work if a compositing windowmanager is
        # present (e.g. xcompmgr, compiz, etc.).
        transparency = 5;

        # Don't remove messages, if the user is idle (no mouse or keyboard input)
        # for longer than idle_threshold seconds.
        # Set to 0 to disable.
        idle_threshold = 0;

        # Which monitor should the notifications be displayed on.
        monitor = 0;

        # Display notification on focused monitor.  Possible modes are:
        #   mouse: follow mouse pointer
        #   keyboard: follow window with keyboard focus
        #   none: don't follow anything
        #
        # "keyboard" needs a windowmanager that exports the
        # _NET_ACTIVE_WINDOW property.
        # This should be the case for almost all modern windowmanagers.
        #
        # If this option is set to mouse or keyboard, the monitor option
        # will be ignored.
        follow = "none";

        # Should a notification popped up from history be sticky or timeout
        # as if it would normally do.
        sticky_history = true;

        # Maximum amount of notifications kept in history
        history_length = 15;

        # Display indicators for URLs (U) and actions (A).
        show_indicators = false;

        # The height of a single line.  If the height is smaller than the
        # font height, it will get raised to the font height.
        # This adds empty space above and under the text.
        line_height = 3;

        # Draw a line of "separatpr_height" pixel height between two
        # notifications.
        # Set to 0 to disable.
        separator_height = 2;

        # Padding between text and separator.
        padding = 6;

        # Horizontal padding.
        horizontal_padding = 6;

        # Define a color for the separator.
        # possible values are:
        #  * auto: dunst tries to find a color fitting to the background;
        #  * foreground: use the same color as the foreground;
        #  * frame: use the same color as the frame;
        #  * anything else will be interpreted as a X color.
        separator_color = "frame";

        # Print a notification on startup.
        # This is mainly for error detection, since dbus (re-)starts dunst
        # automatically after a crash.
        startup_notification = false;

        # dmenu path.
        dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst";

        # Browser for opening urls in context menu.
        browser = "${pkgs.firefox}/bin/firefox -new-tab";

        # Align icons left/right/off
        icon_position = false;
        max_icon_size = 80;

        frame_width = 3;
        frame_color = "#8EC07C";
      };
      shortcuts = {
        # Shortcuts are specified as [modifier+][modifier+]...key
        # Available modifiers are "ctrl", "mod1" (the alt-key), "mod2",
        # "mod3" and "mod4" (windows-key).
        # Xev might be helpful to find names for keys.

        # Close notification.
        #close = ctrl+space;

        # Close all notifications.
        #close_all = ctrl+shift+space

        # Redisplay last message(s).
        # On the US keyboard layout "grave" is normally above TAB and left
        # of "1".
        #history = ctrl+grave

        # Context menu.
        #context = ctrl+shift+period
      };
      urgency_low = {
        # IMPORTANT: colors have to be defined in quotation marks.
        # Otherwise the "#" and following would be interpreted as a comment.
        frame_color = "#3B7C87";
        foreground = "#3B7C87";
        background = "#191311";
        #background = "#2B313C";
        timeout = 4;
      };
      urgency_normal = {
        frame_color = "#5B8234";
        foreground = "#5B8234";
        background = "#191311";
        #background = "#2B313C"
        timeout = 6;
      };
      urgency_critical = {
        frame_color = "#B7472A";
        foreground = "#B7472A";
        background = "#191311";
        #background = "#2B313C";
        timeout = 8;
      };
    };
  };

  services.picom = {
    enable = true;
    backend = "xrender";
    vSync = true;
  };

  xresources.properties = {
    "Xcursor.size" = 48;
    "Xft.dpi" = 136;
    "Xft.autohint" = 0;
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintfull";
    "Xft.hinting" = 1;
    "Xft.antialias" = 1;
    "Xft.rgba" = "rgb";
  };


  xsession.enable = true;
  xsession.scriptPath = "${config.xdg.configHome}/xsession";
  programs.fish.loginShellInit = ''
        if not set -q DISPLAY && test "$XDG_VTNR" -eq 1
            set -gx XAUTHORITY ${config.xdg.cacheHome}/Xauthority
            exec ${pkgs.xorg.xinit}/bin/startx ${config.xsession.scriptPath} 2> ~/log2.txt > ~/log1.txt
        end
  '';
  xsession.windowManager.i3 = let
    modifier = "Mod4";
  in
  {
    enable = true;

    config = {
      modifier = "${modifier}";

      bars = [
        { workspaceNumbers = false; }
      ];

      keybindings = let
        workspaces = [
          "q" "w" "e" "r"
          "a" "s" "d" "f"
          "z" "x" "c" "v"
        ];
        workspaceKeybinds = with lib; listToAttrs (
          flatten (
            imap1 (i: ws: [
              { name = "${modifier}+${ws}";       value = "workspace \"${toString i}:${ws}\""; }
              { name = "${modifier}+Shift+${ws}"; value = "move container to workspace \"${toString i}:${ws}\""; }
            ])
            workspaces
          )
        );
      in
      {
        "${modifier}+Return"   = "exec ${pkgs.kitty}/bin/kitty";
        "${modifier}+space"    = "exec ${pkgs.dmenu}/bin/dmenu_run";



        # change focus
        "${modifier}+h"       = "focus left";
        "${modifier}+j"       = "focus down";
        "${modifier}+k"       = "focus up";
        "${modifier}+l"       = "focus right";

        # move focused window
        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+Shift+BackSpace" = "kill";

        "${modifier}+Shift+Escape" = "restart";
        "mod1+mod4+Escape"         = "exit";

        "${modifier}+u" = "layout toggle tabbed splitv splith";
      } // workspaceKeybinds;

      startup = [
        { notification = false; command = "${pkgs.xorg.xset}/bin/xset r rate 200 50"; }
        { notification = false; command = "${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr"; }
        { notification = false; command = "${pkgs.hsetroot}/bin/hsetroot -solid '#404040'"; }
        { notification = false; command = "${pkgs.picom}/bin/picom --backend glx --unredir-if-possible --vsync opengl-swc --config $HOME/.config/compton.conf"; }
        { notification = false; command = "${pkgs.xorg.xrdb}/bin/xrdb -merge $HOME/.Xresources"; }
      ];

      window = {
        commands = [
          # { command = "border pixel 3"; criteria = { class = "Firefox"; }; }
        ];
      };
    };
  };

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = 1;
    _JAVA_AWT_WM_NONREPARENTING=1;
  };
}

