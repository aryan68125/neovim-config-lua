return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup()
    vim.keymap.set("n","<leader>gp",":Gitsigns preview_hunk<CR>",{})
    vim.keymap.set("n","<leader>clb",":Gitsigns toggle_current_line_blame<CR>",{})
    vim.keymap.set("n","<leader>diff",":Gitsigns toggle_word_diff<CR>",{})
  end
}
