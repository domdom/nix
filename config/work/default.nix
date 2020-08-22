{lib, pkgs, config, ...}:

let
  jdk7 = (pkgs.callPackage jdk/jdk7-linux.nix {});
  jdk8 = (pkgs.callPackage jdk/jdk8-linux.nix {});
  jdk9 = (pkgs.callPackage jdk/jdk9-linux.nix {});
  jdk11 = (pkgs.callPackage jdk/jdk11-linux.nix {});
in
  {
    home.packages = with pkgs; [
      # Work utilities
      openconnect
      thunderbird
      firefox

      # Code review
      (callPackage ./rbtools.nix {})

      # IDE
      jetbrains.clion

      # Help with reducing test cases
      creduce

      # environment setup
      lorri
      direnv

      # packaging
      perl bzip2 zip

      gcc
      gdb

      # build tools for the environment
      gnumake
      ninja
      # Optional
      ccache
      include-what-you-use
    ];

    # Setup a dev environment for cremerie
    home.file."work/c/shell.nix".source = config.lib.file.mkOutOfStoreSymlink ./cremerie-shell.nix;
    home.file."work/c/.envrc".text = ''eval "$(lorri direnv)"'';
  }
