{config, pkgs, lib, ...}:

with lib;
with pkgs;
let
  git-check = writeScriptBin "git-check-for-repo" ''
    #!/usr/bin/env bash
    git rev-parse HEAD > /dev/null 2>&1
  '';

  make-script = {name, body, ...}: writeScriptBin name ''
    #!/usr/bin/env bash
    ${git-check}/bin/git-check-for-repo || exit 1

    fzf-down() {
      fzf --height 50% "$@" --border
    }

    ${body}
  '';
  cat = if config.programs.bat.enable then
      "${pkgs.bat}/bin/bat --color=always --style=numbers,changes,header"
  else
      "${pkgs.cat}/bin/cat";

  git-fzf-functions = [
    {
      bind = "h";
      name = "git-fzf-commits";
      body = ''
        git l --graph --color=always |
        fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
        --header 'Press CTRL-S to toggle sort' \
        --preview 'grep -o "[a-f0-9]\{7,\}" (echo {} | psub) | xargs git show --color=always | head -'$(tput lines) |
        grep -o "[a-f0-9]\{7,\}"
      '';
    }
    {
      bind = "f";
      name = "git-fzf-files";
      body = ''
        git -c color.status=always status --short |
        fzf-down -m --ansi --nth 2..,.. \
        --preview 'begin git diff --color=always -- {-1} | sed 1,4d; ${cat} {-1}; end | head -500' |
        cut -c4- | sed 's/.* -> //'
      '';
    }
    {
      bind = "b";
      name = "git-fzf-branches";
      body = ''
        git branch -a --color=always | grep -v '/HEAD\s' | sort |
        fzf-down --ansi --multi --tac --preview-window right:70% \
        --preview 'git l --color=always (sed s/^..// <<< {} | cut -d" " -f1) | head -'$(tput lines) |
        sed 's/^..//' | cut -d' ' -f1 |
        sed 's#^remotes/##'
      '';
    }
    {
      bind = "t";
      name = "git-fzf-tags";
      body = ''
        git tag --sort -version:refname |
        fzf-down --multi --preview-window right:70% \
        --preview 'git show --color=always {} | head -'$(tput lines)
      '';
    }
  ];
  enableFishIntegration = config.programs.fish.enable;
in
  {
    home.packages = [ git-check ] ++ map make-script git-fzf-functions;

    programs.fish.interactiveShellInit = mkIf enableFishIntegration ''
      ${concatMapStrings ({name, ...}: ''
          function ${name}-widget
            set -l results (${name});
            and commandline -i "$results"
            commandline -f repaint
          end
      '') git-fzf-functions}

      ${concatMapStrings ({name, bind, ...}: ''
        bind \cg\c${bind} ${name}-widget
      '') git-fzf-functions}
    '';
  }
