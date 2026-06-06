vim.pack.add({
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/williamboman/mason-lspconfig.nvim',
  'https://github.com/nvimtools/none-ls.nvim',
  'https://github.com/neovim/nvim-lspconfig',
})

require("mason").setup()
require("mason-lspconfig").setup({ auto_install = true })

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.prettier,
  },
})

vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("bashls")

vim.lsp.config("eslint", {
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all",
    },
    format = true,
  },
})
vim.lsp.enable("eslint")

vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation, {})
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.code_action, {})
vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})
vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {})
vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
vim.keymap.set("n", "<leader>gl", ":LspEslintFixAll<CR>", {})
