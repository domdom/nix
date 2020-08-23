{config, pkgs, lib, ...}:

with lib;

let
  settings = (import ./shell.nix) { config = config; };
in
  {
    programs.direnv.enable = true;
    programs.fish = {
      enable = true;
      shellAbbrs = settings.aliases;
      promptInit = ''
        function fish_prompt
          set_color -o
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

      functions = let
        move-or-search = direction: direction2: {
          description = "Depending on cursor position and current mode, either search ${direction} or move ${direction2} one line";
          body = ''
            if commandline --search-mode
                commandline -f history-prefix-search-${direction}
                return
            end

            if commandline --paging-mode
                commandline -f ${direction2}-line
                return
            end

            set lineno (commandline -L)

            switch $lineno
                case 1
                    commandline -f history-prefix-search-${direction}

                case '*'
                    commandline -f ${direction2}-line
            end
          '';
          };
      in
      {
        up-or-prefix-search = move-or-search "backward" "up";
        down-or-prefix-search = move-or-search "forward" "down";
      };
      shellInit = ''
          set -p fish_function_path ${pkgs.fish-foreign-env}/share/fish-foreign-env/functions
          if test -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
            fenv source /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
          end
          set -e fish_function_path[1]
      '';
      interactiveShellInit = ''
        bind \cj down-or-prefix-search
        bind \ck up-or-prefix-search

        ${optionalString config.programs.fzf.enable ''
          source ${pkgs.fzf}/share/fzf/key-bindings.fish
          fzf_key_bindings
        ''}

        if test -f ~/.fish_local
          source ~/.fish_local
        end
      '';
    };
  }
