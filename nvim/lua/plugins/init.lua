return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    -- daftar LSP yang ingin diinstall otomatis
    ensure_installed = {
      "gopls",
      "pyright",
      "rust_analyzer",
      "jsonls",
      "yamlls",
      "html",
      "cssls",
      "ts_ls",
    },
    automatic_installation = true,  
  },
},

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css", "java", "go"
      },
      auto_install = true,
      highlight = {enable = true},
      indent = {enable = true}
    },
  },
  -- java 
  {
    "mfussenegger/nvim-jdtls",
  },
  {
      "b0o/schemastore.nvim",
  },
  {
    "mg979/vim-visual-multi"
  }
 -- 
--  {
--    "elmcgill/springboot-nvim",
--    dependencies = {
--        "neovim/nvim-lspconfig",
--        "mfussenegger/nvim-jdtls",
--        "nvim-tree/nvim-tree.lua",
--    },
--    config = function()
--        local springboot_nvim = require("springboot-nvim")
--        springboot_nvim.setup({})
--    end
--
--  }
}
