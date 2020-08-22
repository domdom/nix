{ pkgs, lib, ... }:


{
  home.packages = with pkgs; [
      gitAndTools.git-absorb
  ];

  programs.git = {
    enable = true;

    package = pkgs.gitAndTools.gitFull;

    delta.enable = true;

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
      commit = {
        verbose = true;
      };
    };
  };
}
