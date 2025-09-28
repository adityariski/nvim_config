vim.cmd.colorscheme 'main'

vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 100
vim.opt.hlsearch = true
vim.opt.confirm = true

vim.keymap.set({ 'x', 'v' }, 'p', function()
  vim.cmd '"_"d'
  vim.cmd 'normal! P'
end, { noremap = true, silent = true })
vim.keymap.set({ 'x', 'v', 'n' }, 'c', '"_c', { noremap = true, silent = true })
vim.keymap.set({ 'x', 'v', 'n' }, 'x', '"_x', { noremap = true, silent = true })

vim.keymap.set({ 'n', 'i' }, '<C-\\>', '<cmd>Rest run<CR>')
vim.keymap.set({ 'n', 'i' }, '<C-c>', '<Esc><cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'numToStr/Comment.nvim' },
  { 'rest-nvim/rest.nvim' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-dadbod' },
  { 'kristijanhusak/vim-dadbod-ui' },
  { 'kristijanhusak/vim-dadbod-completion' },
  {
    'j-hui/fidget.nvim',
    config = function()
      local custom_config = require('fidget.notification').default_config
      custom_config.name = nil
      custom_config.icon = nil
      require('fidget').setup {
        notification = {
          override_vim_notify = false,
          configs = { default = custom_config },
          window = { winblend = 0 },
        },
      }
      -- local ui_ns = vim.api.nvim_create_namespace 'custom_namespace'
      -- local ui_opts = { ext_messages = true }
      -- ---@diagnostic disable-next-line
      -- vim.ui_attach(ui_ns, ui_opts, function(event, ...)
      --   if event == 'msg_show' then
      --     local kind, content, replace_last, history, append, msg_id = ...
      --     for _, x in pairs(content) do
      --       vim.notify(x)
      --     end
      --   end
      -- end)
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'rcarriga/nvim-notify',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      vim.go.lazyredraw = true
      local notify = require 'notify'
      notify.setup { stages = 'static', merge_duplicates = true }

      require('noice').setup {
        popupmenu = { kind_icons = false },
        cmdline = {
          view = 'cmdline',
          format = {
            lua = false,
            help = false,
            input = false,
            filter = false,
            cmdline = false,
            search_up = false,
            search_down = false,
          },
        },
        lsp = {
          hover = { enabled = false },
          progress = { enabled = false },
          signature = { enabled = false },
          message = { enabled = true, view = 'notify', opts = {} },
        },
      }
    end,
  },
  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    opts = {
      delay = 0,
      icons = {
        mappings = false,
      },
    },
  },
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
    },
    config = function()
      require('telescope').setup {
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown() },
        },
      }
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>/', function()
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- { 'hrsh7th/nvim-cmp', opts = {} },
      -- { 'saghen/blink.cmp', opts = {} },
      { 'mason-org/mason.nvim', opts = {} },
      { 'mason-org/mason-lspconfig.nvim', opts = {} },
      { 'WhoIsSethDaniel/mason-tool-installer.nvim', opts = {} },
    },
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
          map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
          map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
          map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

          local function client_supports_method(client, method, bufnr)
            if vim.fn.has 'nvim-0.11' == 1 then
              return client:supports_method(method, bufnr)
            else
              return client.supports_method(method, { bufnr = bufnr })
            end
          end

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.diagnostic.config {
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = {},
        virtual_text = {
          source = 'if_many',
          spacing = 2,
          format = function(diagnostic)
            local diagnostic_message = {
              [vim.diagnostic.severity.ERROR] = diagnostic.message,
              [vim.diagnostic.severity.WARN] = diagnostic.message,
              [vim.diagnostic.severity.INFO] = diagnostic.message,
              [vim.diagnostic.severity.HINT] = diagnostic.message,
            }
            return diagnostic_message[diagnostic.severity]
          end,
        },
      }

      ---@class LspServersConfig
      ---@field mason table<string, vim.lsp.Config>
      ---@field others table<string, vim.lsp.Config>
      local servers = {
        mason = {
          -- ['htmx-lsp'] = {},
          ['html-lsp'] = {},
          intelephense = {},
          pyright = {},
          gopls = {},
          ts_ls = {},
          lua_ls = {
            settings = {
              Lua = {
                completion = {
                  callSnippet = 'Replace',
                },
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          },
          stylua = {},
        },
        others = {},
      }

      local ensure_installed = vim.tbl_keys(servers.mason or {})
      vim.list_extend(ensure_installed, { 'black', 'isort' })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      -- capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)
      -- require('mason-lspconfig').setup {
      --   handlers = {
      --     function(server_name)
      --       local server = servers[server_name] or {}
      --       server.capabilities = vim.tbl_deep_extend('force', {}, capabilities)
      --       vim.lsp.config(server_name, server)
      --       vim.lsp.enable(server_name, true)
      --     end,
      --   },
      -- }

      for server, config in pairs(vim.tbl_extend('keep', servers.mason, servers.others)) do
        if not vim.tbl_isempty(config) then
          vim.lsp.config(server, config)
        end
      end
      require('mason-lspconfig').setup { ensure_installed = {}, automatic_enable = true }

      if not vim.tbl_isempty(servers.others) then
        vim.lsp.enable(vim.tbl_keys(servers.others))
      end
    end,
  },
  {
    'saghen/blink.cmp',
    event = 'VimEnter',
    version = '*',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        version = '*',
        build = 'make install_jsregexp', -- WARN: need make build tool!
        opts = {},
      },
      {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
    },
    opts = {
      keymap = { preset = 'default' },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      completion = {
        documentation = { auto_show = false },
        menu = {
          draw = {
            treesitter = { 'lsp' },
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind' },
            },
          },
        },
      },
      cmdline = {},
      sources = {
        default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer' },
        providers = {
          lazydev = {
            name = 'lazydev',
            module = 'lazydev.integrations.blink',
            score_offset = 100,
          },
        },
      },
      snippets = { preset = 'luasnip' },
      signature = { enabled = true },
      fuzzy = { implementation = 'rust' },
      -- fuzzy = { implementation = 'lua' },
    },
    opts_extend = { 'sources.default' },
  },
  -- {
  --   'hrsh7th/nvim-cmp',
  --   event = 'InsertEnter',
  --   dependencies = {
  --     {
  --       'L3MON4D3/LuaSnip',
  --       build = (function()
  --         if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
  --           return
  --         end
  --         return 'make install_jsregexp'
  --       end)(),
  --       dependencies = {
  --         {
  --           'rafamadriz/friendly-snippets',
  --           config = function()
  --             require('luasnip.loaders.from_vscode').lazy_load()
  --           end,
  --         },
  --       },
  --       opts = {},
  --     },
  --     'saadparwaiz1/cmp_luasnip',
  --     'hrsh7th/cmp-path',
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-nvim-lsp-signature-help',
  --   },
  --   config = function()
  --     local cmp = require 'cmp'
  --     local luasnip = require 'luasnip'
  --     luasnip.config.setup {}
  --     cmp.setup {
  --       snippet = {
  --         expand = function(args)
  --           luasnip.lsp_expand(args.body)
  --         end,
  --       },
  --       completion = { completeopt = 'menu,menuone,noinsert' },
  --       mapping = cmp.mapping.preset.insert {
  --         ['<C-n>'] = cmp.mapping.select_next_item(),
  --         ['<C-p>'] = cmp.mapping.select_prev_item(),
  --         ['<C-b>'] = cmp.mapping.scroll_docs(-4),
  --         ['<C-f>'] = cmp.mapping.scroll_docs(4),
  --         ['<C-y>'] = cmp.mapping.confirm { select = true },
  --         ['<C-Space>'] = cmp.mapping.complete {},
  --         ['<C-l>'] = cmp.mapping(function()
  --           if luasnip.expand_or_locally_jumpable() then
  --             luasnip.expand_or_jump()
  --           end
  --         end, { 'i', 's' }),
  --         ['<C-h>'] = cmp.mapping(function()
  --           if luasnip.locally_jumpable(-1) then
  --             luasnip.jump(-1)
  --           end
  --         end, { 'i', 's' }),
  --       },
  --       sources = {
  --         { name = 'lazydev', group_index = 0 },
  --         { name = 'nvim_lsp' },
  --         { name = 'luasnip' },
  --         { name = 'path' },
  --         { name = 'nvim_lsp_signature_help' },
  --         { name = 'vim-dadbod-completion' },
  --         { name = 'buffer' },
  --       },
  --     }
  --   end,
  -- },
  {
    'stevearc/conform.nvim',
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    opts = { signs = false },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = {},
        section_separators = {},
      },
      sections = {
        lualine_c = {
          { 'lsp_status', symbols = { spinner = { '' }, done = '', separator = ', ' } },
          { 'filename' },
          -- { 'filename', path = 2 },
        },
      },
    },
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup()
      require('mini.ai').setup { n_lines = 500 }
      -- local statusline = require 'mini.statusline'
      -- statusline.setup { use_icons = false }
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
      ensure_installed = {
        'fish',
        'bash',
        'go',
        'diff',
        'html',
        'lua',
        'luadoc',
        'markdown',
        'vim',
        'vimdoc',
        'http',
        'python',
        'javascript',
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      -- matchup = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {
    'vhyrro/luarocks.nvim',
    config = function() end,
    opts = {
      -- Specify LuaRocks packages to install
      rocks = { 'lua-curl', 'nvim-nio', 'mimetypes', 'xml2lua' },
    },
  },
  {
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup()
    end,
    opts = {},
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
    },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup()
      vim.keymap.set('n', '<C-a>', function()
        harpoon:list():remove()
        harpoon:list():add()
      end)
      vim.keymap.set('n', '<C-e>', function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end)
      vim.keymap.set('n', '<A-1>', function()
        harpoon:list():select(1)
      end)
      vim.keymap.set('n', '<A-2>', function()
        harpoon:list():select(2)
      end)
      vim.keymap.set('n', '<A-3>', function()
        harpoon:list():select(3)
      end)
      vim.keymap.set('n', '<A-4>', function()
        harpoon:list():select(4)
      end)
      vim.keymap.set('n', '<A-5>', function()
        harpoon:list():select(5)
      end)
      vim.keymap.set('n', '<A-6>', function()
        harpoon:list():select(6)
      end)
      vim.keymap.set('n', '<A-7>', function()
        harpoon:list():select(7)
      end)
      vim.keymap.set('n', '<A-8>', function()
        harpoon:list():select(8)
      end)
      vim.keymap.set('n', '<A-9>', function()
        harpoon:list():select(9)
      end)
      vim.keymap.set('n', '<A-0>', function()
        harpoon:list():select(0)
      end)
    end,
  },
}, {
  ui = {
    border = 'rounded',
  },
})
