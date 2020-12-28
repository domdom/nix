{ config, pkgs, lib, ... }:

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
  vim-groovy = buildVimPluginFrom2Nix {
    pname = "vim-groovy";
    version = "1";
    src = fetchGit {
      url = "git@github.com:modille/groovy.vim";
      ref = "master";
      rev = "392419dafb8a2f0a93f605ba5b1e90ba48f1644d";
    };
  };
  vim-elm-syntax = buildVimPluginFrom2Nix {
    pname = "vim-elm-syntax";
    version = "1";
    src = fetchGit {
      url = "git@github.com:andys8/vim-elm-syntax";
      ref = "master";
      rev = "d614325a037982489574012e4db04d7f8f134c17";
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

        # deoplete-nvim
        ## prosession isn't available, so wont bother with obsession
        # Adds automatic session management
        # vim-obsession
        # Automatically load session based on folder
        # vim-prosession

        # Language server
        # LanguageClient-neovim
        coc-nvim
        #coc-clangd
        #coc-json

        # Git gutter
        vim-signify
        # Git plugin
        vim-fugitive

        # fzf
        #fzfWrapper
        fzf-vim

        ## Syntaxes
        vim-cpp-modern
        vim-nix
        vim-llvm
        vim-groovy

        # Adds elm syntax and other features
        vim-elm-syntax

        # syntax highlighting for fish_shell
        vim-fish
      ];
    };
    home.sessionVariables = {
      # EDITOR = "${config.programs.neovim.finalPackage}/bin/nvim";
    };
    home.packages = with pkgs; [
      # Required for coc-nvim
      nodejs
    ];
  }










