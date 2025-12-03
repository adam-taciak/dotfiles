-- lsp.lua (Updated for lsp-zero v3.x)

local lsp = require('lsp-zero')

-- The preset now returns a table of settings for lsp-zero.
-- We will use this later.
local lsp_preset = lsp.preset('recommended')

-- Your custom on_attach function.
-- This is kept exactly as you had it.
lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}

  vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
  vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
  vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
  vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
  vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
  vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
  vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
  vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
  vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)


-- Your preferences are preserved.
-- lsp.set_preferences is still a valid function.
lsp.set_preferences({
  suggest_lsp_servers = false,
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

---
-- This is where the main changes are
--
require('mason').setup({})
require('mason-lspconfig').setup({
  -- REPLACES |lsp.ensure_installed()|
  -- These are the servers you had previously.
  -- Note: `sumneko_lua` is now called `lua_ls`.
  ensure_installed = {
    'tsserver',
    'eslint',
    'lua_ls',
  },
  handlers = {
    -- This is the default handler, which will pass your on_attach and other settings
    lsp.default_setup,

    -- REPLACES |lsp.nvim_workspace()|
    -- This is a custom handler for lua_ls to add Neovim globals
    lua_ls = function()
      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = {'vim'},
            },
          },
        },
      })
    end,
  }
})

-- REPLACES |lsp.setup_nvim_cmp()|
-- You now configure nvim-cmp directly.
local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

cmp.setup({
  -- These are the sources lsp.preset('recommended') used to use.
  sources = cmp.config.sources({
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
    {name = 'path'},
  }),
  -- Your custom mappings are preserved here.
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- We explicitly set <Tab> and <S-Tab> to nil to unmap them, just like you had.
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  },
  -- Required for LuaSnip to work with nvim-cmp.
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- This call remains.
lsp.setup()

-- Your diagnostic config remains.
vim.diagnostic.config({
  virtual_text = true
})
