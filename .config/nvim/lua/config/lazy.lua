-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
-- local lsp_attach = function(client, bufnr)
--   local opts = { buffer = bufnr, noremap = true, silent = true }
--   vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
--   vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
--   vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
--   vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
--   vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, noremap = true, silent = true })
--   vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
--   vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
--   vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
--   vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
-- end

require("lazy").setup({
  spec = {
    {
      "OXY2DEV/markview.nvim",
      -- config = function ()
      --   require("markview").setup({
      --     experimental = {
      --       check_rtp_message = false,
      --     }})
      -- end,
      lazy = false,
    },
    {
      "max397574/better-escape.nvim",
      config = function()
        require("better_escape").setup()
      end,
    },
    {
      "williamboman/mason.nvim",
      build = ":MasonUpdate",
      config = true,
    },
{
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "clangd", "svelte", "ts_ls", "pyright", "gopls", "intelephense" },
    })

    -- Load LSP configurations from separate files
    -- require('plugins.intelephense').setup()

    -- Configure other LSP servers as needed
    require('lspconfig').lua_ls.setup({})
    require('lspconfig').clangd.setup({})
    -- etc...
  end,
},
    {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v4.x',
    },
    {
      'stevearc/oil.nvim',
      ---@module 'oil'
      ---@type oil.SetupOpts
      opts = {},
      dependencies = { { "echasnovski/mini.icons", opts = {} } },
      lazy = false,
      config = function ()
        require("oil").setup{
          default_file_explorer = true,
          delete_to_trash = true,
          skip_confirm_for_simple_edits = true,
          view_options = {
            show_hidden = true,
            natural_order = true,
            is_always_hidden = function(name, _)
              return name == '..' or name == '.git'
            end,
          },
          win_options = {
            wrap = true
          }
        }
      end
    },
    {
      "ntpeters/vim-better-whitespace"
    },
    {
      "folke/snacks.nvim",
      priority = 1000,
      lazy = false,
      ---@type snacks.Config
      opts = {
        ---@class snacks.indent.Config
        indent = {
          enabled = true
        },
      },
      init = function()
        vim.api.nvim_create_autocmd("User", {
          pattern = "VeryLazy",
          callback = function()
          end,
        })
      end
    },
    {
      'nvim-flutter/flutter-tools.nvim',
      lazy = false,
      dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
      },
      config = function()
        require("flutter-tools").setup {
          lsp = {
            color = {
              enabled = true,
              background = false
            }
          }
        }
      end
    },
    {
      "shortcuts/no-neck-pain.nvim",
      config = function()
        require("no-neck-pain").setup({
          buffers = {
            wo = {
              fillchars = "eob: ",
            },
            right = {
              enabled = false,
            },
          },
        })
        vim.cmd(string.format("NoNeckPain", f))
      end
    },
    {
      'ggandor/leap.nvim',
      config = function ()
        vim.keymap.set('n',        's', '<Plug>(leap-anywhere)')
        vim.keymap.set({'x', 'o'}, 's', '<Plug>(leap)')
      end
    },
    {
      'saghen/blink.cmp',
      -- optional: provides snippets for the snippet source
      dependencies = { 'rafamadriz/friendly-snippets' },

      -- use a release tag to download pre-built binaries
      version = '1.*',
      -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
      -- build = 'cargo build --release',
      -- If you use nix, you can build from source using latest nightly rust with:
      -- build = 'nix run .#build-plugin',

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      opts = {
        keymap = { preset = 'enter' },

        appearance = {
          nerd_font_variant = 'mono'
        },

        completion = {
          documentation = { auto_show = true
          },
          ghost_text = {
            enabled = true
          }
        },

        sources = {
          default = { 'lsp', 'path', 'snippets'},
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
      },
      opts_extend = { "sources.default" }
    },
    {
      "kawre/leetcode.nvim",
      build = ":TSUpdate html",
      dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim", -- required by telescope
        "MunifTanjim/nui.nvim",

        -- optional
        "nvim-treesitter/nvim-treesitter",
        "rcarriga/nvim-notify",
        "nvim-tree/nvim-web-devicons",
      },
      opts = {
        -- configuration goes here
      },
    },
    { "windwp/nvim-ts-autotag",
      config = function()
        require('plugins.autotag')
      end
    },
    {
      'nvim-lualine/lualine.nvim',
      dependencies = { 'nvim-tree/nvim-web-devicons' },
      config = function()
        require('plugins.lualine')  -- Load your external lualine configuration
      end,
    },
    {"tpope/vim-commentary"},
    {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = { "nvim-lua/plenary.nvim" }
    },
    { "neovim/nvim-lspconfig" },
    {"pmizio/typescript-tools.nvim"},
    {
      "jiaoshijie/undotree",
      dependencies = "nvim-lua/plenary.nvim",
      config = true,
      keys = { -- load the plugin only when using it's keybinding:
        { "<leader><F5>", "<cmd>lua require('undotree').toggle()<cr>" },
      },
    },
    {
      "kdheepak/lazygit.nvim",
      lazy = true,
      cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      keys = {
        { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
      }
    },
    {
      'windwp/nvim-autopairs',
      event = "InsertEnter",
      config = true
    },
    {'nvim-telescope/telescope.nvim', tag = '0.1.8'},
    {
      'AAR072/vercel-theme.nvim',
      lazy = false,
      priority = 1000,
      config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        -- vim.g.gruvbox_material_enable_italic = true
        -- vim.g.gruvbox_material_enable_bold = true
        -- vim.g.gruvbox_material_enable_bold = true
        vim.cmd.colorscheme('vercel')
      end
    },
    {'nvim-telescope/telescope.nvim', tag = '0.1.8'},
    {
      "ray-x/go.nvim",
      dependencies = {  -- optional packages
        "ray-x/guihua.lua",
        "neovim/nvim-lspconfig",
        "nvim-treesitter/nvim-treesitter",
      },
      opts = {
        -- lsp_keymaps = false,
        -- other options
      },
      config = function(lp, opts)
        require("go").setup(opts)
        local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = "*.go",
          callback = function()
            require('go.format').goimports()
          end,
          group = format_sync_grp,
        })
      end,
      event = {"CmdlineEnter"},
      ft = {"go", 'gomod'},
      build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
    },
    {
      "nvim-treesitter/nvim-treesitter",
      build = ":TSUpdate",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects", -- Add textobjects as a dependency
      },
      config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
          ensure_installed = { "typescript", "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "svelte", "dart", "python", "go", "php" },
          highlight = { enable = true },
          indent = { enable = true },
          -- Add textobjects configuration
          textobjects = {
            select = {
              enable = true,
              lookahead = true,
              keymaps = {
                ["af"] = "@function.outer", -- Around function (includes `def`/`function` and `end`)
                ["if"] = "@function.inner", -- Inside function (body only)
                ["ac"] = "@class.outer",    -- Around class
                ["ic"] = "@class.inner",    -- Inside class
              },
            },
            move = {
              enable = true,
              set_jumps = true,
              goto_next_start = {
                ["]m"] = "@function.outer", -- Jump to next function start
                ["]]"] = "@class.outer",    -- Jump to next class start
              },
              goto_previous_start = {
                ["[m"] = "@function.outer", -- Jump to previous function start
                ["[["] = "@class.outer",    -- Jump to previous class start
              },
            },
          },
        })
      end,
    },
    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
        {
          "<leader>xX",
          "<cmd>Trouble diagnostics toggle<cr>",
          desc = "Diagnostics (Trouble)",
        },
        {
          "<leader>xx",
          "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
          desc = "Buffer Diagnostics (Trouble)",
        },
        {
          "<leader>cs",
          "<cmd>Trouble symbols toggle focus=false<cr>",
          desc = "Symbols (Trouble)",
        },
        {
          "<leader>cl",
          "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
          desc = "LSP Definitions / references / ... (Trouble)",
        },
        {
          "<leader>xL",
          "<cmd>Trouble loclist toggle<cr>",
          desc = "Location List (Trouble)",
        },
        {
          "<leader>xQ",
          "<cmd>Trouble qflist toggle<cr>",
          desc = "Quickfix List (Trouble)",
        },
      },
    }
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "vercel" } },
  -- Do not automatically check for plugin updates
  checker = { enabled = true},
})

-- LSP Setup
-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file

