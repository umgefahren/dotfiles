local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
  {
    "rcarriga/nvim-notify",
    config = function()
      require("notify").setup {
        stages = "fade",
      }
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        progress = { enabled = true },
        signature = { enabled = false },
        hover = { enabled = true },
        notify = { enabled = true },
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function(_, opts)
      require("noice").setup(opts)
    end,
  },

  -- Override plugin definition options
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "zbirenbaum/copilot.lua",
    event = "InsertEnter",
    cmd = "Copilot",
    config = function()
      require("copilot").setup {
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-CR>",
          },
        },
      }
    end,
  },

  {
    "folke/drop.nvim",
    event = "VimEnter",
    opts = {
      theme = "leaves",
      screensaver = 1000 * 60 * 5,
    },
    config = function(_, opts)
      require("drop").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      enable = true,
    },
    config = function(_, opts)
      require("treesitter-context").setup(opts)
    end,
  },

  {
    "nvim-tree/nvim-web-devicons",
  },

  {
    "nvimdev/lspsaga.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "neovim/nvim-lspconfig",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      border_style = "rounded",
      preview_lines_above = 3,
      lightbulb = { virtual_text = false },
    },
    config = function(_, opts)
      require("lspsaga").setup(opts)
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    event = { "BufReadPost *.rs" },
    ft = { "rust" },
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = (function()
      local on_attach = require("plugins.configs.lspconfig").on_attach
      local capabilities = require("plugins.configs.lspconfig").capabilities
      return {
        server = {
          capabilities = capabilities,
          on_attach = on_attach,
          keys = {
            { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
            { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
          },
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
                loadOutDirsFromCheck = true,
                runBuildScripts = true,
              },
              -- Add clippy lints for Rust.
              checkOnSave = {
                allFeatures = true,
                command = "clippy",
              },
              procMacro = {
                enable = true,
                -- ignored = {
                --   ["async-trait"] = { "async_trait" },
                --   ["napi-derive"] = { "napi" },
                --   ["async-recursion"] = { "async_recursion" },
                -- },
              },
              interpret = {
                tests = true,
              },
            },
          },
        },
      }
    end)(),
    config = function(_, opts)
      require("rust-tools").setup(opts)
    end,
  },

  {
    "saecki/crates.nvim",
    tag = "v0.4.0",
    event = "BufRead Cargo.toml",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      null_ls = {
        enabled = true,
      },
    },
    config = function(_, opts)
      require("crates").setup(opts)
    end,
  },

  {
    "justinhj/battery.nvim",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    event = "VimEnter",
    opts = {
      vertical_icons = false,
      show_plugged_icon = false,
      show_unplugged_icon = false,
      show_status_when_no_battery = false,
    },
    config = function(_, opts)
      if vim.g.neovide then
        opts.vertical_icons = true
        opts.show_plugged_icon = true
        opts.show_unplugged_icon = true
      end
      require("battery").setup(opts)
    end,
  },

  {
    "tpope/vim-repeat",
  },

  {
    "ggandor/leap.nvim",
    lazy = false,
    dependencies = "tpope/vim-repeat",
    config = function(_, _)
      require("leap").add_default_mappings()
    end,
  },

  {
    "tomasky/bookmarks.nvim",
    event = "VimEnter",
    opts = {
      sign_priority = 10,
      save_file = vim.fn.expand "$HOME/.bookmarks", -- bookmarks save file path
      keywords = {
        ["@t"] = "☑️ ", -- mark annotation startswith @t ,signs this icon as `Todo`
        ["@w"] = "⚠️ ", -- mark annotation startswith @w ,signs this icon as `Warn`
        ["@f"] = "⛏ ", -- mark annotation startswith @f ,signs this icon as `Fix`
        ["@n"] = "! ", -- mark annotation startswith @n ,signs this icon as `Note`
        ["@q"] = "? ",
        ["@c"] = "~ ", -- mark annotation startswith @c ,signs this icon as `change`
      },
    },
    config = function(_, opts)
      require("bookmarks").setup(opts)
      require("telescope").load_extension "bookmarks"
    end,
  },

  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },

  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
            },
          },
        },
      }
    end,
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
