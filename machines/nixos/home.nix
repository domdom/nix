{ pkgs, ... }:

{
  imports = [
    ../../config/unix-base.nix
    # graphical stuff?
    # bspwm, terminal etc
    ../../config/i3wm.nix

    ../../config/work
  ];
  xdg.enable = true;
}
