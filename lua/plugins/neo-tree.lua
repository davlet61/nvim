return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      close_if_last_window = true,
      enable_diagnostics = true,
      filesystem = {
        filtered_items = {
          visible = true, -- This is what you want: If you set this to `true`, all "hide" just mean "dimmed out"
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
      sort_case_insensitive = true,
      group_empty_dirs = true,
      window = {
        position = "right",
        mappings = {
          h = "parent_or_close",
          l = "child_or_open",
          O = "system_open",
          o = "open",
        },
      },
    })
  end,
}
