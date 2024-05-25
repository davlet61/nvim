---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    local Terminal = require("toggleterm.terminal").Terminal
    local superfile = Terminal:new {
      cmd = "spf .",
      -- dir = vim.fn.getcwd(),
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd "startinsert!"
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
      -- function to run on closing the terminal
      on_close = function(term) vim.cmd "startinsert!" end,
    }

    vim.keymap.set("n", "<leader>ts", function() superfile:toggle() end, { desc = "Toggle superfile" })
  end,
}
