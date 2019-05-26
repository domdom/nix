{ pkgs, ...}:

{
  home.packages = with pkgs; [
    # fzf and fd go together for use in vim and on commandline
    fzf fd
    ripgrep
    jq
  ] ++ lib.optionals pkgs.stdenv.isDarwin [
    # Better userland for macOS
    coreutils
    findutils
    gawk
    gnugrep
    gnused
  ];

  programs.home-manager = {
    enable = true;
    path = https://github.com/rycee/home-manager/archive/master.tar.gz;
  };

  programs.alacritty = {
    enable = true;
    settings = {
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
