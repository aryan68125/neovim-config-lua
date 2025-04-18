return {
    "kdheepak/lazygit.nvim",
    lazy = true,
    -- Innvchad environemnt for neovim this method of setting up key binding only work
    config = function()
      require("gitsigns").setup()
      vim.keymap.set("n","<leader>lg",":LazyGit",{})
      vim.keymap.set("n","<leader>lgc",":LazyGitConfig",{})
      vim.keymap.set("n","<leader>lgcf",":LazyGitCurrentFile",{})
      vim.keymap.set("n","<leader>lgf",":LazyGitFilter",{})
      vim.keymap.set("n","<leader>lgfcf",":LazyGitFilterCurrentFile",{})
    end,

    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    -- This method of key bindings did not work for me in nvchad setup although this will work if you are setting up neovim from scratch
    keys = {
        -- { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit", mode = "n" }
    }
}
