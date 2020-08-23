{pkgs, config, ...}:

{
  programs.kitty = {
    enable = true;

    settings = {
      scrollbackLines = 30000;
      allow_remote_control = true;
      shell = "${pkgs.fish}/bin/fish --login";
      enabled_layouts = "horizontal";

      font_family = "Menlo Bold";
      font_size = 14;
      macos_option_as_alt = true;
    };

    keybindings = {
        # TODO: work out what to do for linux
        "super+h" = "previous_window";
        "super+l" = "next_window";
    };

    extraConfig = ''
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
    '';
  };
}

