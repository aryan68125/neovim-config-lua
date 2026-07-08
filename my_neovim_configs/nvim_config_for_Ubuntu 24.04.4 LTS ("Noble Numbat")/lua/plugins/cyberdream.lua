return {
  "scottmckendry/cyberdream.nvim", -- ✅ correct repo
  lazy = false,
  priority = 1000,
  config = function()
  require("cyberdream").setup({
    transparent = true, -- Enable transparency
  })
  vim.cmd("colorscheme cyberdream")
  end
}
