return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "nix",
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, { nix = { "alejandra", "nixfmt" } })
      --opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft, { nix = { "nixpkgs_fmt" } })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft["nix"] = { "statix" }
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "LnL7/vim-nix" },
    },
    -- opts = {
    --   servers = {
    --     rnix = {},
    --   },
    --   setup = {
    --     rnix = function(_, opts)
    --       local lspcontroller = require("framework.controller.lspcontroller"):new()
    --       lspcontroller:setup_lsp_servers(_, opts)
    --     end,
    --   },
    -- },
    opts = {
      servers = {
        nil_ls = {
          --cmd = { "/etc/profiles/per-user/null0x/bin/nil" },
          cmd = { "nil" },
          settings = {
            ["nil"] = {
              textSetting = 42,
              formatting = {
                command = { "nixpkgs-fmt" },
              },
              autoArchive = true,
            },
          },
        },
      },
      setup = {
        nil_ls = function(_, opts)
          local lspcontroller = require("framework.controller.lspcontroller"):new()
          lspcontroller:setup_lsp_servers(_, opts)
        end,
      },
    },
  },
}
