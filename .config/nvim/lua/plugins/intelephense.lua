-- ~/.config/nvim/lua/plugins/lsp/intelephense.lua
local lspconfig = require('lspconfig')
local util = require('lspconfig.util')

local M = {}

function M.setup()
  lspconfig.intelephense.setup({
    -- More strict root directory detection
    root_dir = function(fname)
      local wp_root = util.root_pattern('wp-config.php', 'wp-load.php')(fname)
      if wp_root and string.match(wp_root, "odtn%-news/app/public$") then
        return wp_root
      end
      return nil
    end,

    on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, noremap = true, silent = true }
      vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
      vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
      vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
      vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
      vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, noremap = true, silent = true })
      vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
      vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
      vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
      vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,

    settings = {
      intelephense = {
        stubs = {
          "wordpress",
          "Core",
          "PDO",
          "json",
        },
        environment = {
          includePaths = {
            "/Users/aa/Local Sites/odtn-news/app/public",
            "/Users/aa/Local Sites/odtn-news/app/public/wp-content/plugins/drive-importer/vendor",
          }
        },
      },
    },
  })
end

return M
