vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/MunifTanjim/nui.nvim',
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
})

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
