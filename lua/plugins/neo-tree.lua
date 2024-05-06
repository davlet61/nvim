return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.close_if_last_window = true
    opts.enable_diagnostics = true
    opts.filesystem.filtered_items = {
      visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_by_name = {
        ".git",
        ".DS_Store",
        "thumbs.db",
      },
    }
    opts.sort_case_insensitive = true
    opts.group_empty_dirs = true
    opts.window = {
      position = "right",
      -- width = "100%",
    }
    return opts
  end,
}
