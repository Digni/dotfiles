return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        registries = {
          "github:mason-org/mason-registry",
          "github:Crashdummyy/mason-registry",
        },
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "bicep",
          "fsautocomplete",
          "gopls",
          "cssls",
          "ts_ls",
          "rust_analyzer",
          "copilot"
        }
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.enable("copilot")
      vim.lsp.config('lua_ls', {
        settings = {
          Lua = {
            hint = {
              enable = true, -- necessary
            }
          }
        }
      })
      vim.lsp.config('gopls', {
        settings = {
          gopls = {
            hints = {
              rangeVariableTypes = true,
              parameterNames = true,
              constantValues = true,
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              functionTypeParameters = true,
            },
          }
        }
      })
      vim.lsp.config('ts_ls', {
      })
      vim.lsp.config('cssls', {
      })
      vim.lsp.config('rust_analyzer', {
        settings = {
          ["rust-analyzer"] = {
            inlayHints = {
              bindingModeHints = {
                enable = false,
              },
              chainingHints = {
                enable = true,
              },
              closingBraceHints = {
                enable = true,
                minLines = 25,
              },
              closureReturnTypeHints = {
                enable = "never",
              },
              lifetimeElisionHints = {
                enable = "never",
                useParameterNames = false,
              },
              maxLength = 25,
              parameterHints = {
                enable = true,
              },
              reborrowHints = {
                enable = "never",
              },
              renderColons = true,
              typeHints = {
                enable = true,
                hideClosureInitialization = false,
                hideNamedConstructor = false,
              },
            },
            check = {
              command = "clippy",
            }
          }
        }
      })

      vim.lsp.config('roslyn', {
        settings = {
          ['csharp|background_analysis'] = {
            dotnet_analyzer_diagnostics_scope = 'fullSolution',
            dotnet_compiler_diagnostics_scope = 'fullSolution',
          },
          ['csharp|inlay_hints'] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
          },
          ['csharp|symbol_search'] = {
            dotnet_search_reference_assemblies = true,
          },
          ['csharp|completion'] = {
            dotnet_show_name_completion_suggestions = true,
            dotnet_show_completion_items_from_unimported_namespaces = true,
            dotnet_provide_regex_completions = true,
          },
          ['csharp|code_lens'] = {
            dotnet_enable_references_code_lens = true,
          },
        }
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})

          vim.lsp.inlay_hint.enable()
          if client.supports_method('textDocument/rename') then
            -- Create a keymap for vim.lsp.buf.rename()
            vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, {})
          end
          if client.supports_method('textDocument/implementation') then
            -- Create a keymap for vim.lsp.buf.implementation
            vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
          end
        end,
      })
    end
  },
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    ---@module 'roslyn.config'
    opts = {
      -- your configuration comes here; leave empty for default settings
    },
  },
}
