{ config, lib, pkgs, ... }:
let myOrg = (pkgs.vimPlugins.orgmode or pkgs.vimPlugins.vim-orgmode);
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          fugitive
          myOrg
          nvim-compe
          nvim-lspconfig
          nvim-tree-lua
          nvim-treesitter
          vim-gitgutter
          #vim-go
          vim-nix
          zig-vim
        ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [ ];
      };
      customRC = ''
        " Restore cursor position
        autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif

        luafile ${./neovim.lua}
      '';
    };
  };
}
