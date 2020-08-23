{ pkgs, ... }:

{
  imports = [
    ../../config/unix-base.nix
    ../../config/kitty.nix
  ];

  home.packages = [
    pkgs.alacritty
  ];

  #programs.bash.enable = true;
  home.file.".bashrc".text = ''
    if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh; then
         source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
    fi
    source "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
  '';
}
