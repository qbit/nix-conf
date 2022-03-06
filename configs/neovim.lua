local execute = vim.api.nvim_command
local fn = vim.fn
local map = vim.api.nvim_set_keymap
local o = vim.o

vim.cmd("syntax off");
vim.cmd("set nolist");
vim.cmd("set ruler");
vim.cmd("set mouse-=a");

require("compe").setup {
   enabled = true;
   autocomplete = true;
   source = {
     path = true;
     buffer = true;
     calc = true;
     nvim_lsp = true;
     nvim_lua = true;
     vsnip = true;
     ultisnips = true;
     luasnip = true;
   };
}

local lspc = require("lspconfig") 
lspc.gopls.setup {};

o.hlsearch = true;

require('orgmode').setup({
  org_agenda_files = {'~/org/*'},
  org_default_notes_file = '~/org/refile.org',
})

-- vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm({ 'keys': '<CR>', 'select': v:true })", { expr = true })
-- nmap <leader>2 :set list!<CR>
-- nmap <leader>3 :set nu!<CR>
-- nmap <leader>4 :set paste!<CR>

