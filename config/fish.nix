{config, pkgs, lib, ...}:

with lib;

let
  settings = (import ./shell.nix) { config = config; };
in
  {
    programs.fish = {
      enable = true;
      shellAbbrs = settings.aliases;
      promptInit = ''
        function fish_prompt
          echo -n '$ '
        end
      '';
      interactiveShellInit = ''
        bind \cj history-search-forward
        bind \ck history-search-backward

        ${optionalString config.programs.fzf.enable ''
          source ${pkgs.fzf}/share/fzf/key-bindings.fish
          fzf_key_bindings
        ''}
        # TODO: Remove this once this bug in fish 3.0 is removed.
        # Fish reorders the path given by bash's environment
        set PATH $HOME/.nix-profile/bin (string match -v $HOME/.nix-profile/bin $PATH)
      '';
    };

    programs.bash = {
      enable = true;
      bashrcExtra = ''
        source $HOME/.nix-profile/etc/profile.d/nix.sh
        exec fish
      '';
    };
  }
