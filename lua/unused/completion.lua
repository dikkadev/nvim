return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
        local ls = require "luasnip"

        -- TODO: Think about `locally_jumpable`, etc.
        -- Might be nice to send PR to luasnip to use filters instead for these functions ;)

        vim.snippet.expand = ls.lsp_expand

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.snippet.active = function(filter)
          filter = filter or {}
          filter.direction = filter.direction or 1

          if filter.direction == 1 then
            return ls.expand_or_jumpable()
          else
            return ls.jumpable(filter.direction)
          end
        end

        ---@diagnostic disable-next-line: duplicate-set-field
        vim.snippet.jump = function(direction)
          if direction == 1 then
            if ls.expandable() then
              return ls.expand_or_jump()
            else
              return ls.jumpable(1) and ls.jump(1)
            end
          else
            return ls.jumpable(-1) and ls.jump(-1)
          end
        end

        vim.snippet.stop = ls.unlink_current

        -- ================================================
        --      My Configuration
        -- ================================================
        ls.config.set_config {
          history = true,
          updateevents = "TextChanged,TextChangedI",
          override_builtin = true,
        }

        for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
          loadfile(ft_path)()
        end

        vim.keymap.set({ "i", "s" }, "<c-k>", function()
          return vim.snippet.active { direction = 1 } and vim.snippet.jump(1)
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<c-j>", function()
          return vim.snippet.active { direction = -1 } and vim.snippet.jump(-1)
        end, { silent = true })

        vim.opt.completeopt = { "menu", "menuone", "noselect" }
        vim.opt.shortmess:append "c"

        local lspkind = require "lspkind"
        lspkind.init {}

        local cmp = require "cmp"

        cmp.setup {
          sources = {
            { name = "nvim_lsp" },
            { name = "cody" },
            { name = "path" },
            { name = "buffer" },
          },
          mapping = {
            ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
            ["<C-y>"] = cmp.mapping(
              cmp.mapping.confirm {
                behavior = cmp.ConfirmBehavior.Insert,
                select = true,
              },
              { "i", "c" }
            ),
          },

          -- Enable luasnip to handle snippet expansion for nvim-cmp
          snippet = {
            expand = function(args)
              vim.snippet.expand(args.body)
            end,
          },
        }

        -- Setup up vim-dadbod
        -- cmp.setup.filetype({ "sql" }, {
        --   sources = {
        --     { name = "vim-dadbod-completion" },
        --     { name = "buffer" },
        --   },
        -- })
    end,
  },
}
