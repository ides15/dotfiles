return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader><space>", LazyVim.telescope("files", { cwd = false }), desc = "Find Files (Root Dir)" },
    { "<leader>/", LazyVim.telescope("live_grep"), desc = "Grep (Root Dir)" },
  },
}
