{config}:

{
  history = {
    file = "${config.xdg.dataHome}/history";
    lines = 10000000;
  };
  aliases = {
    ls = "ls -h --color=auto";
    la = "ls -la";
    ll = "ls -l";
    l = "ll";

    v = "vim";

    less = "less -R";

    ":q" = "exit";
  };
}
