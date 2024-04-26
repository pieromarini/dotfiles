return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "cpp",
        "lua",
        "vim",
        "javascript",
        "typescript",
        "java",
        "jsdoc",
        "json",
        "json5",
        "html",
        "diff",
        "css",
        "bash",
        "make",
        "cmake",
        "python",
        "scss",
        "vue",
        "xml"
      },
      auto_install = true,
      highlight = { enable = true }
    })
  end
}
