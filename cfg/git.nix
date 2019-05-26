{ pkgs, ... }:


{
  programs.git = {
    enable = true;

    userName = "domdom";
    userEmail = "dom@dfer.me";

    aliases = {
      # One-line log
      l  = "!git lt --all";

      lt = ''!git log -n 60 --graph --source --format=tformat:'%C(bold blue)%h%C(yellow):%Creset%s %C(green)%an%Creset%C(dim white) (%ar)%C(auto)%n%-d%Creset' '';

      # Verbose log
      v = ''log --graph --all --source --stat \
              --format=format:'%w(0,0,1)%C(cyan)%H%Creset%C(auto)%d%Creset%n%n%C(yellow)%cD%Creset %C(green)(%cr)%Creset%n%C(yellow)%an %C(dim white)<%ae>%n%n%Creset%s%n%n%-b%n' '';

      out = ''log --graph HEAD --not --remotes --source \
          --format=tformat:'%C(cyan)%h%Creset%C(dim white):%Creset%<(90,trunc)%s %C(dim white)%<(17,trunc)%an%Creset %C(green)%cd%C(auto)%n%-D%Creset' '';

      s = "status --short";
      d = "diff";
      ds = "diff --staged";

      st = "status";

      co = "commit";
      amend = "commit --amend";

      up = "pull --rebase --autostash";

      fush = "push --force-with-lease";
    };
  };
}
