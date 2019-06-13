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

        function fzf-history-widget -d "Show command history"
          set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
          begin
            set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m"

            set -l FISH_MAJOR (echo $version | cut -f1 -d.)
            set -l FISH_MINOR (echo $version | cut -f2 -d.)

            # history's -z flag is needed for multi-line support.
            # history's -z flag was added in fish 2.4.0, so don't use it for versions
            # before 2.4.0.
            if [ "$FISH_MAJOR" -gt 2 -o \( "$FISH_MAJOR" -eq 2 -a "$FISH_MINOR" -ge 4 \) ];
              history -z \
                | awk 'BEGIN{RS="\0"} !seen[$0]++' \
                | eval (__fzfcmd) --read0 -q '(commandline)' | perl -pe 'chomp if eof' | read -lz result
              and commandline -- $result
            else
              history | eval (__fzfcmd) -q '(commandline)' | read -l result
              and commandline -- $result
            end
          end
          commandline -f repaint
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
        # Then add local bin directory
        set PATH $HOME/.local/bin (string match -v $HOME/.local/bin $PATH)
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
