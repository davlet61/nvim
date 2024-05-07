-- Customize Treesitter

---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.6",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      defaults = {
        prompt_prefix = "   ",
        mappings = {
          i = {
            ["<C-h>"] = "which_key",
          },
        },
      },
    })
  end,
}
