return {
  "nvim-treesitter/nvim-treesitter-context",
  event = "User AstroFile",
  vim.keymap.set(
    "n",
    "[c",
    function() require("treesitter-context").go_to_context(vim.v.count1) end,
    { silent = true }
  ),
}
