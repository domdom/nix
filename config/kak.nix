{pkgs, ...}:

{
  programs.kakoune = {
    enable = true;
    config = {
      colorScheme = "default";

      numberLines = {
        enable = true;
      };
    };
  };
}
