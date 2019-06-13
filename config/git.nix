{ pkgs, ... }:


{
  programs.git = {
    enable = true;

    aliases = {
      # One-line log
      l  = "!git lt --all";

      lt = ''!git log --graph --source --format=tformat:'%C(bold blue)%h%C(yellow):%Creset%s %C(green)%an%Creset%C(dim white) (%ar)%C(auto)%n%-d%Creset' '';

      # Verbose log
      v = ''log --graph --all --source --stat \
              --format=format:'%w(0,0,1)%C(cyan)%H%Creset%C(auto)%d%Creset%n%n%C(yellow)%cD%Creset %C(green)(%cr)%Creset%n%C(yellow)%an %C(dim white)<%ae>%n%n%Creset%s%n%n%-b%n' '';

      out = ''log --graph HEAD --not --remotes --source \
          --format=tformat:'%C(cyan)%h%Creset%C(dim white):%Creset%<(90,trunc)%s %C(dim white)%<(17,trunc)%an%Creset %C(green)%cd%C(auto)%n%-D%Creset' '';

      s = "status --short";
      d = "diff";
      ds = "diff --staged";

      st = "status";
      se = "!git status --short | fzf -m --height 40% --layout=reverse | awk '{print $2}' | xargs -r nvim";
      sf = "!git status --short | fzf -m --height 40% --layout=reverse | awk '{print $2}'";

      co = "commit";
      amend = "commit --amend";

      up = "pull --rebase --autostash";

      fush = "push --force-with-lease";

      r = "rebase -i --autostash --autosquash";
    };

    extraConfig = {
      push = {
        default = "current";
      };

      include = {
        path = "~/.gitconfig_local";
      };

      absorb = {
        maxStack = 50;
      };

      pager = {
        log = ''less -F -J -j2 -p "'HEAD ->'"'';
      };
    };
  };
}
