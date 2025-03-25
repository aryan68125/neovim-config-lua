return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional but recommended
  config = function()
    require("lualine").setup({
      options = { theme = "auto" }
    })
  end,
}


