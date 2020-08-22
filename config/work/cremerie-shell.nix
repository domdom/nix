{ pkgs ? import <nixpkgs> {} }:

let

    jdk7 = (pkgs.callPackage jdk/jdk7-linux.nix {});
    jdk8 = (pkgs.callPackage jdk/jdk8-linux.nix {});
    jdk9 = (pkgs.callPackage jdk/jdk9-linux.nix {});
    jdk11 = (pkgs.callPackage jdk/jdk11-linux.nix {});
in
  pkgs.mkShell {
    buildInputs = with pkgs; [
      cmake
      #################################
      # Cremerie
      #################################
      # Build inputs
      python27   # build.py, tests
      clang      # compilation
      lld        # linker
      bison flex
      zlib.static
      zlib.dev

      # Required for tests
      gcc
      #(wrapCC gcc-unwrapped)
      jdk7
      jdk8
      jdk9
      jdk11
    ];

    JDK7 = "${jdk7}";
    JDK8 = "${jdk8}";
    JDK9 = "${jdk9}";
    JDK11 = "${jdk11}";
  }
