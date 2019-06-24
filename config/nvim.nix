{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    configure = {
      customRC = builtins.readFile vim/vimrc;
      plug.plugins = with pkgs.vimPlugins; [
        vim-plug
      ];
    };
  };
}
