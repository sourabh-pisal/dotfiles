return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme "catppuccin-frappe"
    require("catppuccin").setup({
      default_integration = true
    })
  end
}
