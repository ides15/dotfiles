return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      width = 60,
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        always_show = {
          ".env.local",
          "outputs.json",
        },
      },
    },
  },
}
