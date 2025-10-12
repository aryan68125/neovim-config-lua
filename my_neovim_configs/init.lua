require 'core.options'
require 'core.keymaps'

-- Wrap and break lines nicely
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = "↪ "
vim.opt.breakindent = true

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end 
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins. STARTS
require('lazy').setup({
	--Neotree related configuration STARTS
{
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
  }
},
{
  "nvim-treesitter/nvim-treesitter",
  run = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup {
      ensure_installed = { "lua" },
      highlight = { enable = true },
      indent = { enable = true },
    }
  end
},
	--Neotree related configuration ENDS

-- lazygit related configurations STARTS
{
  "kdheepak/lazygit.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
  end
},
-- lazygit related configurations ENDS
	
    --Theme related configuration STARTS
{
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
},
    --Load theme related plugins 
require("plugins.lualine"),
require("plugins.cyberdream"),
	--Theme related configuration ENDS

{
    "famiu/bufdelete.nvim"  -- Plugin to delete buffers
},
})

-- Load additional plugin configs
require("plugins.neotree")

-- Apply colorscheme automatically
vim.cmd.colorscheme "cyberdream"
-- NOTE: Here is where you install your plugins. END
























































































































