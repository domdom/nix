{ pkgs, lib, ... }:

with pkgs.vimUtils;
let
  vim-fish = buildVimPluginFrom2Nix {
    pname = "vim-fish";
    version = "2019-06-30";
    src = fetchGit {
      url = "git@github.com:dag/vim-fish";
      ref = "master";
      rev = "50b95cbbcd09c046121367d49039710e9dc9c15f";
    };
  };
in
  {
    programs.neovim = {
      enable = true;
      vimAlias = true;
      configure = {
        customRC = builtins.readFile vim/vimrc;
        plug.plugins = with pkgs.vimPlugins; [
          # The plugin manager
          vim-plug
          # Color scheme
          vim-one

          deoplete-nvim
          ## prosession isn't available, so wont bother with obsession
          # Adds automatic session management
          # vim-obsession
          # Automatically load session based on folder
          # vim-prosession

          # Git gutter
          vim-signify
          # Git plugin
          vim-fugitive

          # fzf
          fzfWrapper
          fzf-vim

          # Syntaxes
          # vim-llvm # not available
          # vim-cpp-modern # not available
          vim-nix

          # build plugin
          vim-fish
        ];
      };
    };
  }
