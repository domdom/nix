{ config, ...}:

{
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        decorations = "none";
      };
      key_bindings = [
        {
          key = "N";
          mods = "Command";
          command = {
            program = "open";
            args = [ "-nb" "io.alacritty" ];
          };
        }
      ];
    };
  };
}
