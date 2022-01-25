{ config, lib, pkgs, ... }:
with lib; {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; {
        # loaded on launch
        start = [
          fugitive
          nvim-compe
          nvim-lspconfig
          nvim-treesitter
          orgmode
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
