{ config, lib, pkgs, ... }:
let myOrg = (pkgs.vimPlugins.orgmode or pkgs.vimPLugins.vim-orgmode);
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        start = [
          fugitive
          nvim-compe
          nvim-lspconfig
          nvim-treesitter
          myOrg
          vim-gitgutter
          vim-go
          vim-nix
          zig-vim
        ];
        # manually loadable by calling `:packadd $plugin-name`
        opt = [ ];
      };
      customRC = ''
        luafile ${./neovim.lua}
              '';
    };
  };
}
