-- Change default runtime path of neovim
vim.opt.runtimepath:remove(vim.fn.expand("~/.config/nvim"))
vim.opt.packpath:remove(vim.fn.expand("/opt/homebrew/Cellar/neovim/0.10.2_1/share/nvim/runtime"))

-- Set new runtime and packpath
vim.opt.runtimepath:append(vim.fn.expand("~/.config/vscode-nvim/config"))
vim.opt.packpath:append(vim.fn.expand("~/.config/vscode-nvim/runtime"))

-- add package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.opt.timeoutlen = 300
vim.opt.smartcase = true  -- Don't ignore case with capitals
vim.opt.smartindent = true
vim.opt.sidescrolloff = 8 -- Columns of context
vim.opt.signcolumn = "yes"
vim.opt.scrolloff = 4     -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2
vim.opt.colorcolumn = "100"
vim.opt.foldmethod = "manual"
vim.opt.spelllang = "en_us"
vim.opt.spell = true
vim.o.cursorlineopt = 'both' -- to enable cursorline!

-- disable s in normal mode
vim.keymap.set("n", "s", "")

-- set system clipboard as default clipboard
vim.opt.clipboard = "unnamedplus"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      keys = require("configs.flash").keys,
    },
    {
      "echasnovski/mini.surround",
      keys = require("configs.mini-surround").keys,
      opts = require("configs.mini-surround").options,
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
