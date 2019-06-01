{pkgs, ...}:

{
  home.packages = with pkgs; [
    kakoune
  ];
}
