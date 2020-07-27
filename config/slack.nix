{pkgs, ...}:

{
  home.packages = with pkgs; [
    (pkgs.writeScriptBin "slack" ''
      #!/usr/bin/env bash
      source $HOME/.config/shell/proxy.bash
      surf -z 1.5 "https://app.slack.com/client"
    '')
    surf
  ];
}
