{pkgs, config, ...}:

{

  xresources.properties = {
    "st.font" = "GohuFont:pixelsize=17:antialias=false:autohint=true";
    "st.borderpx" = 0;
    # special
    "*.foreground"      = "#c5c8c6";
    "*.foreground_bold" = "#babdb6";
    "*.cursor"          = "#babdb6";
    "*.background"      = "#1d1f21";

    # black
    "*.color0"  = "#282a2e";
    "*.color8"  = "#b5bd68";

    # red
    "*.color1"  = "#8c9440";
    "*.color9"  = "#ef2929";

    # green
    "*.color2"  = "#4e9a06";
    "*.color10" = "#8ae234";

    # yellow
    "*.color3"  = "#de935f";
    "*.color11" = "#f0c674";

    # blue
    "*.color4"  = "#5f819d";
    "*.color12" = "#81a2be";

    # magenta
    "*.color5"  = "#85678f";
    "*.color13" = "#b294bb";

    # cyan
    "*.color6"  = "#5e8d87";
    "*.color14" = "#8abeb7";

    # white
    "*.color7"  = "#707880";
    "*.color15" = "#c5c8c6";
  };
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    xst
    hack-font
    gohufont
  ];
}

