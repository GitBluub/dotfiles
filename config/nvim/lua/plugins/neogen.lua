return {
  "danymat/neogen",
  dependencies = "nvim-treesitter/nvim-treesitter",
  opts = {
    languages = {
      cs = {
        template = {
          annotation_convention = "xmldoc",
        },
      },
    },
  },
  keys = {
    { "<leader>n", "<cmd>Neogen<cr>", desc = "Generate documentation" },
  },
}
