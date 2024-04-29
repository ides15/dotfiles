return {
  "nvim-telescope/telescope.nvim",
  keys = {
    { "<leader><space>", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>/", LazyVim.telescope("live_grep"), desc = "Grep (Root Dir)" },
  },
}