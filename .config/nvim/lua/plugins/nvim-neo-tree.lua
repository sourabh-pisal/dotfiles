return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      filesystem = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_hidden = false,
        follow_current_file = {
          enabled = true,
          leave_dir_open = false,
        }
      }
    })

    vim.keymap.set("n", "<C-n>", ":Neotree toggle<CR>", {})
    vim.keymap.set("n", "<leader>b", ":Neotree buffers<CR>", {})
  end
}
