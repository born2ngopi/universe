
require("nvchad.configs.lspconfig").defaults()



local on_attach = function(client, bufnr)
    -- keymaps tambahan
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd",
      function ()
        vim.lsp.buf.definition()

        vim.defer_fn(function()
          if vim.fn.getqflist({ size = 0 }).size > 0 then
            vim.cmd("cclose")
          end
        end, 3000) -- delay 200 ms
      end
      ,opts)

    vim.keymap.set("n", "gr",
      function ()
        vim.lsp.buf.references()
        vim.defer_fn(function()
          if vim.fn.getqflist({ size = 0 }).size > 0 then
            vim.cmd("cclose")
          end
        end, 3000) -- delay 200 ms
      end
      , opts)
    vim.keymap.set("n", "gc",
      function ()
        vim.lsp.buf.implementation()
        vim.defer_fn(function()
          if vim.fn.getqflist({ size = 0 }).size > 0 then
            vim.cmd("cclose")
          end
        end, 3000) -- delay 200 ms
      end
      , opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

    -- format otomatis ketika save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { async = false }
      end,
    })
  end


-- override for gopls
vim.lsp.config["gopls"] = {
  settings= {
    gopls={
      gofumpt = true,             -- formatter strict
      usePlaceholders = true,     -- placeholders in completion
      completeUnimported = true,  -- auto delete unused package
      staticcheck = true,         -- linter
      analyses = {
        unusedparams = true,
        shadow = true,
      },
    },
  },
  on_attach = on_attach,
}

-- override for rust-analyzer
vim.lsp.config["rust_analyzer"] = {
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = {
        command = "clippy",  -- pakai clippy buat linting
      },
      imports = {
        granularity = { group = "module" },
        prefix = "self",
      },
    },
  },
}

-- override for python
vim.lsp.config["pyright"] = {
  on_attach = on_attach,
  settings = {
    python = {
      analysis = {
        autoImportCompletions = true,
        typeCheckingMode = "basic", -- "off", "basic", "strict"
        diagnosticMode = "workspace", -- cek seluruh project
        useLibraryCodeForTypes = true,
      },
    },
  },
}

-- override for json
vim.lsp.config["jsonls"] = {
  on_attach = on_attach,
  settings = {
    json = {
      schemas = require('schemastore').json.schemas(), -- optional, but awesome
      validate = { enable = true },
    },
  },
}

-- override for yaml
vim.lsp.config["yamlls"] = {
  on_attach = on_attach,
  settings = {
    yaml = {
      keyOrdering = false,
      format = { enable = true },
      validate = true,
      hover = true,
      completion = true,
      schemas = {
        ["https://json.schemastore.org/kubernetes.json"] = "/*.k8s.yaml",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
        ["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
        ["https://json.schemastore.org/docker-compose.json"] = "/docker-compose*.yaml",
      },
    },
  },
}

local servers = { "html", "cssls", "gopls" , "rust_analyzer", "pyright", "jsonls", "yamlls"}
vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers 
