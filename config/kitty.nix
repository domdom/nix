{pkgs, config, ...}:

{
  programs.kitty = {
    enable = true;

    settings = {
      scrollbackLines = 30000;
      allow_remote_control = true;
      shell = "${pkgs.fish}/bin/fish --login";
      enabled_layouts = "horizontal";

      font_family = "Hack";
      font_size = 10;
      macos_option_as_alt = true;
    };

    keybindings = {
        # TODO: work out what to do for linux
        "super+h" = "previous_window";
        "super+l" = "next_window";
    };

    extraConfig = ''
      cursor_text_color background

      foreground #1b1f23
      foreground_bold #1b1f23
      background #ffffff

      color0  #1b1f23
      color1  #d73a49
      color2  #28a745
      color3  #f68a0a
      color4  #0364d2
      color5  #6e3ec7
      color6  #28c0ac
      color7  #d6d9dc
      color8  #3e4853
      color9  #f2717f
      color10 #50c76b
      color11 #f2ab3e
      color12 #4f96e6
      color13 #a883ee
      color14 #68dfcf
      color15 #ffffff
    '';

    /*

    primer old
      color0 #1b1f23
      color8 #24292e
      color1 #d73a49
      color9 #ffdce0
      color2 #28a745
      color10 #dcffe4
      color3 #dbab09
      color11 #ffd33d
      color4 #0366d6
      color12 #f1f8ff
      color5 #ea4aaa
      color13 #ea4aaa
      color6 #6f42c1
      color14 #f5f0ff
      color7 #24292e
      color15 #fafbfc
    */

  /*
        # special
        foreground      #babdb6
        foreground_bold #babdb6
        cursor          #babdb6
        background      #111111

        # black
        color0  #2e3436
        color8  #555753

        # red
        color1  #c61515
        color9  #ef2929

        # green
        color2  #4e9a06
        color10 #8ae234

        # yellow
        color3  #ffd000
        color11 #e9df0a

        # blue
        color4  #3465a4
        color12 #729fcf

        # magenta
        color5  #a311bb
        color13 #ad7fa8

        # cyan
        color6  #06989a
        color14 #34e2e2

        # white
        color7  #d3d7cf
        color15 #eeeeec
*/
  };
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    hack-font
    gohufont
  ];
}

