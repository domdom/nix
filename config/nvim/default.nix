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
  vim-cpp-modern = buildVimPluginFrom2Nix {
    pname = "vim-cpp-modern";
    version = "2019-07-01";
    src = fetchGit {
      url = "git@github.com:bfrg/vim-cpp-modern";
      ref = "master";
      rev = "9d571f17d194ba694191aa0c6b65b73477103e1d";
    };
  };
  vim-llvm = buildVimPluginFrom2Nix {
    pname = "vim-llvm";
    version = "1";
    src = fetchGit {
      url = "git@github.com:rhysd/vim-llvm";
      ref = "master";
      rev = "64f121c447154debbe0ee6670380190bb58ae4aa";
    };
  };
in
  {
    programs.neovim = {
      enable = true;
      vimAlias = true;

      extraConfig = builtins.readFile ./vimrc;

      plugins = with pkgs.vimPlugins; [
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
        vim-cpp-modern
        vim-nix
        vim-llvm

        # build plugin
        vim-fish
      ];
    };
  }
