-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = {
  "html",
  "cssls",
  "tsserver",
  "zls",
  "terraformls",
  "helm_ls",
  "zls",
  "ols",
  "markdown_oxide",
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.clangd.setup {
  on_attach = on_attach,
  cmd = {
    "/opt/homebrew/opt/llvm/bin/clangd",
    "--background-index",
    "--pch-storage=memory",
    "--all-scopes-completion",
    "--pretty",
    "--header-insertion=never",
    "-j=4",
    "--inlay-hints",
    "--header-insertion-decorators",
    "--function-arg-placeholders",
    "--completion-style=detailed",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  capabilities = capabilities,
}

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
  settings = {
    ["rust_analyzer"] = {
      diagnostics = {
        enable = true,
      },
    },
  },
}

-- Disable diagnostics globally
vim.diagnostic.config {
  virtual_text = false,
  signs = false,
  underline = false,
  update_in_insert = false,
  severity_sort = false,
}

lspconfig.gopls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  rootdir = lspconfig.util.root_pattern("go.mod", ".git", "go.work"),
  fyletypes = { "go", "gomod", "tmpl" },
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
      gofumpt = true,
      staticcheck = true,
      analyses = {
        unusedparams = true,
      },
    },
  },
}
