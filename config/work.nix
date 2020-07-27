{lib, pkgs, ...}:

{
  imports = [
    ./slack.nix
  ];
  home.packages = with pkgs; [
    openconnect
    thunderbird
    firefox

    # email
    aerc

    # direnv based shell setup for cremerie directories
    lorri
    direnv

    creduce


    # build tools for the environment
    ninja
    gnumake
    python37

    jetbrains.clion


    (callPackage ./rbtools.nix {})
  ];
  # services.lorri.enable = true;
}
