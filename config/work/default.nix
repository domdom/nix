{lib, pkgs, config, ...}:

let
  jdk7 = (pkgs.callPackage jdk/jdk7-linux.nix {});
  jdk8 = (pkgs.callPackage jdk/jdk8-linux.nix {});
  jdk9 = (pkgs.callPackage jdk/jdk9-linux.nix {});
  jdk11 = (pkgs.callPackage jdk/jdk11-linux.nix {});
  #clang-tools = (pkgs.llvmPackages_10.clang-tools.override { stdenv = pkgs.llvmPackages_10.stdenv; });
in
  {
    home.packages = with pkgs; [
      # Work utilities
      openconnect
      thunderbird
      firefox
      zoom-us


      # Code review
      (callPackage ./rbtools.nix {})

      # IDE
      jetbrains.clion
      jetbrains.pycharm-community
      jetbrains.idea-community

      # Help with reducing test cases
      creduce
      valgrind
      kcachegrind
      bloaty
      python27
      python38

      sublime3

      # offline documentation browser
      zeal
      graphviz

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
      clang-tools
      ccache
      include-what-you-use
    ];

    # Setup a dev environment for cremerie
    home.file."work/c/shell.nix".source = config.lib.file.mkOutOfStoreSymlink ./cremerie-shell.nix;
    home.file."work/c/.envrc".text = ''eval "$(lorri direnv)"'';
  }
