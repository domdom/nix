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
          set_color brgreen
          echo -n (pwd | sed -e "s|^$HOME|~|")
          set_color normal
          echo -n ' $ '
        end

        function save_cmd_to_bash --on-event fish_preexec
          echo $argv >> "$HOME/.bash_history"
        end

        function history --wraps history
          if contains -- -z $argv
            builtin history $argv | awk 'BEGIN{ RS="\0"; ORS="\0" } !seen[$0]++'
          else
            builtin history $argv
          end
        end
      '';
      interactiveShellInit = ''
        bind \cj history-search-forward
        bind \ck history-search-backward

        # TODO: Remove this once this bug in fish 3.0 is removed.
        # Fish reorders the path given by bash's environment
        set PATH $HOME/.nix-profile/bin (string match -v $HOME/.nix-profile/bin $PATH)
        # Then add local bin directory
        set PATH $HOME/.local/bin (string match -v $HOME/.local/bin $PATH)
        # Add my bin scripts
        set PATH $HOME/bin (string match -v $HOME/bin $PATH)

        ${optionalString config.programs.fzf.enable ''
          source ${pkgs.fzf}/share/fzf/key-bindings.fish
          fzf_key_bindings
        ''}
      '';
    };

    programs.bash = {
      enable = true;
      bashrcExtra = ''
        [ -f "$HOME/.bashrc_local" ] && source "$HOME/.bashrc_local"
        exec fish
      '';
    };
  }
