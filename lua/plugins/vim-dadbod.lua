return {
  "kristijanhusak/vim-dadbod-ui",
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
    { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
  },

  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_win_position = "right"

    -- vim.api.nvim_create_autocmd("BufEnter", {
    --   pattern = "dbui",
    --   callback = function()
    --     -- Get listed buffers
    --     local bufs = vim.fn.getbufinfo { bufloaded = true }
    --     -- Notify the buffer info for debugging
    --     vim.notify(vim.inspect(bufs), vim.log.levels.INFO)
    --
    --     -- if vim.api.nvim_buf_get_option(buf.bufnr, "filetype") == "alpha" then
    --     --   vim.cmd("bd " .. buf.bufnr)
    --     -- vim.cmd "enew"
    --     -- end
    --   end,
    -- })
  end,
}
