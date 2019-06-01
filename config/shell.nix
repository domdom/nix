{config}:

{
  history = {
    file = "${config.xdg.dataHome}/history";
    lines = 10000000;
  };
  aliases = {
    la = "ls -la";
    ll = "ls -l";
    l = "ll";

    v = "vim";

    less = "less -R";

    ":q" = "exit";
  };
}
