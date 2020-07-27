{ pkgs, lib, ... }:


{
  home.packages = with pkgs; [
    gitAndTools.diff-so-fancy
    gitAndTools.delta
    gitAndTools.git-absorb

    (writeScriptBin "git-sync" ''
      #!/usr/bin/env bash

      git for-each-ref --format='%(refname:short) %(upstream:short)' "refs/heads/**" |
          while read local_branch remote_branch; do
              [[ -z "$remote_branch" ]] && continue
              [[ "$(git rev-parse "$local_branch")" == "$(git rev-parse "$remote_branch")" ]] && continue

              if [[ "$local_branch" == "$(git rev-parse --abbrev-ref HEAD)" ]]; then
                  git pull --rebase --autostash
              else
                  if git merge-base --is-ancestor "$local_branch" "$remote_branch"; then
                      git branch -f "$local_branch" "$remote_branch"
                  fi
              fi
          done
    '')
  ];
  programs.git = {
    enable = true;

    package = pkgs.gitAndTools.gitFull;

    aliases = {
      # One-line log
      la  = "!git l --all";

      l = ''!git log --graph --source --format=tformat:'%C(bold blue)%h%C(yellow):%Creset%s %C(green)%an%Creset%C(dim white) (%ar)%C(auto)%n%-d%Creset' '';

      lr = ''!git l HEAD master origin/master --glob=refs/heads/master --glob=refs/heads/release-\\* --glob=refs/heads/origin/release-\\* --glob=refs/heads/origin/master'';

      # Verbose log
      va = "!git v --all";

      v = ''log --graph --source --stat \
              --format=format:'%w(0,0,1)%C(cyan)%H%Creset%C(auto)%d%Creset%n%n%C(yellow)%cD%Creset %C(green)(%cr)%Creset%n%C(yellow)%an %C(dim white)<%ae>%n%n%Creset%s%n%n%-b%n' '';

      out = ''log --graph HEAD --remotes=origin/(master|release-*) \
          --format=tformat:'%C(cyan)%h%Creset%C(dim white):%Creset%<(90,trunc)%s %C(dim white)%<(17,trunc)%an%Creset %C(green)%cd%C(auto)%n%-D%Creset' '';

      s = "status --short";
      d = "diff";
      ds = "diff --staged";

      st = "status";

      co = "commit";
      amend = "commit --amend";
      ref = "add -u";
      f = "fetch --prune";
      fa = "fetch --all --prune";

      up = "pull --rebase --autostash";

      fush = "push --force-with-lease";

      r = "rebase -i --autostash --autosquash";
    };

    includes = [
      {
        path = "~/work/.gitconfig";
        condition = "gitdir:~/work/**";
      }
      {
        path = "~/personal/.gitconfig";
        condition = "gitdir:~/personal/**";
      }
    ];

    extraConfig = {
      push = {
        default = "current";
      };

      absorb = {
        maxStack = 50;
      };

      core = {
        pager = ''${pkgs.gitAndTools.delta}/bin/delta --theme ansi-dark --width=variable'';
      };

      interactive = {
        diffFilter = ''${pkgs.gitAndTools.delta}/bin/delta --color-only'';
      };

      pager = {
        log = ''${pkgs.gitAndTools.delta}/bin/delta --theme 1337'';
      };
    };
  };
}
