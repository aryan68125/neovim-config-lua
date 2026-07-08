vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
    require("neo-tree.command").execute({ action = "refresh" })
  end,
})

require("neo-tree").setup({
  filesystem = {
    follow_current_file = true, -- Focus on renamed/moved files
    use_libuv_file_watcher = true, -- Enable automatic refresh
  },
})
