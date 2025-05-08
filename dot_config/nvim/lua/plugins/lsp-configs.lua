return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bicep",
          "omnisharp",
          "fsautocomplete",
          "gopls",
          "cssls",
          "ts_ls"
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      local lspconfig = require("lspconfig")

      lspconfig.lua_ls.setup({
        capabilities = capabilities
      })
      lspconfig.bicep.setup({
        capabilities = capabilities
      })
      lspconfig.omnisharp.setup({
        capabilities = capabilities
      })
      lspconfig.fsautocomplete.setup({
        capabilities = capabilities
      })
      lspconfig.gopls.setup({
        capabilities = capabilities
      })
      lspconfig.cssls.setup({
        capabilities = capabilities
      })
      lspconfig.ts_ls.setup({
        capabilities = capabilities
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          vim.keymap.set('n','gD', vim.lsp.buf.declaration, {})
          vim.keymap.set('n','gd', vim.lsp.buf.definition, {})
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
          if client.supports_method('textDocument/rename') then
            -- Create a keymap for vim.lsp.buf.rename()
            vim.keymap.set('n','<leader>R', vim.lsp.buf.rename, {})
          end
          if client.supports_method('textDocument/implementation') then
            -- Create a keymap for vim.lsp.buf.implementation
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
          end
        end,
      })
    end
  }
}
