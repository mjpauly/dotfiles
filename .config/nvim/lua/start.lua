require('gitsigns').setup()
require('fidget').setup()

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.o.completeopt = "menuone,noinsert,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

local function on_attach(client, buffer)
    -- This callback is called when the LSP is atttached/enabled for this buffer
    -- we could set keymaps related to LSP, etc here.

    local keymap_opts = { buffer = buffer }
    -- Code navigation and shortcuts
    vim.keymap.set("n", "<gD>", vim.lsp.buf.declaration, keymap_opts)
    vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
    vim.keymap.set("n", "+", vim.lsp.buf.rename, keymap_opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, keymap_opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
    vim.keymap.set("n", "<c-S>", vim.lsp.buf.signature_help, keymap_opts)
    -- is type_definition the same as .definition?
    vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, keymap_opts)
    vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
    vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
    -- vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)  -- dup
    vim.keymap.set("n", "ga", vim.lsp.buf.code_action, keymap_opts)

    -- Set updatetime for CursorHold
    -- 300ms of no cursor movement to trigger CursorHold
    vim.opt.updatetime = 100

    -- Show diagnostic popup on cursor hover
    local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
    vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
            vim.diagnostic.open_float(nil, { focusable = false })
        end,
        group = diag_float_grp,
    })

    -- Goto previous/next diagnostic warning/error
    vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
    vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)

    -- have a fixed column for the diagnostics to appear in
    -- this removes the jitter when warnings/errors flow in
    vim.wo.signcolumn = "yes"

    local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.rs",
        callback = function()
            vim.lsp.buf.format({ timeout_ms = 200 })
        end,
        group = format_sync_grp,
    })
end

vim.g.rustaceanvim = {
    server = {
        on_attach = on_attach,
    },
}

-- Setup Completion
-- See https://github.com/hrsh7th/nvim-cmp#basic-configuration
local cmp = require("cmp")
cmp.setup({
    preselect = cmp.PreselectMode.None,
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    mapping = {
        -- ["<C-p>"] = cmp.mapping.select_prev_item(),
        -- ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_next_item(),
        ["<C-n>"] = cmp.mapping.select_prev_item(),
        -- Add tab support
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<Tab>"] = cmp.mapping.select_next_item(),
        -- ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        -- ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-d>"] = cmp.mapping.scroll_docs(8),
        ["<C-u>"] = cmp.mapping.scroll_docs(-8),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        -- ["<CR>"] = cmp.mapping.confirm({
            -- behavior = cmp.ConfirmBehavior.Insert,
            -- select = true,
        -- }),
    },

    -- Installed sources
    sources = {
        { name = "nvim_lsp" },
        { name = "vsnip" },
        { name = "path" },
        { name = "buffer" },
    },
})


-- pyright setup

local lspconfig = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = cmp_nvim_lsp.default_capabilities()

lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

-- format on save for python files using `uv run ruff`, bypasses LSP
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.py",
    callback = function(args)
        local buf = args.buf
        local filepath = vim.api.nvim_buf_get_name(buf)
        local input = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")

        -- Run ruff format synchronously
        local output = vim.fn.system({
            "uv", "run", "ruff", "format", "--stdin-filename", filepath, "-"
        }, input)

        local success = vim.v.shell_error == 0
        if success then
            local formatted = vim.split(output, "\n", { plain = true })
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, formatted)
        else
            vim.notify("ruff format failed:\n" .. output, vim.log.levels.ERROR)
        end
    end,
})


-- eslint setup for typescript
-- more info: https://github.com/MunifTanjim/eslint.nvim
-- also: https://dev.to/craftzdog/my-neovim-setup-for-react-typescript-tailwind-css-etc-58fb
-- --[[
-- local null_ls = require("null-ls")  -- disabled after nvim 0.11.0 upgrade

--[[
-- for format on save (not using prettier for now)
local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"
]]--

--[[
null_ls.setup({  -- disabled after nvim 0.11.0 upgrade
  sources = {
    null_ls.builtins.diagnostics.eslint.with({  -- or eslint_d
      diagnostics_format = '[eslint] #{m}\n(#{c})'
    }),
    null_ls.builtins.diagnostics.fish
  },
  --[[
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end
  end,
  ]]--
-- })

--[[
local eslint = require("eslint")  -- disabled after nvim 0.11.0 upgrade
eslint.setup({
  bin = 'eslint', -- or `eslint_d`
  code_actions = {
    enable = true,
    apply_on_save = {
      enable = true,
      types = { "directive", "problem", "suggestion", "layout" },
    },
    disable_rule_comment = {
      enable = true,
      location = "separate_line", -- or `same_line`
    },
  },
  diagnostics = {
    enable = true,
    report_unused_disable_directives = false,
    run_on = "type", -- or `save`
  },
})
]]--

--[[  -- disabled after nvim 0.11.0 upgrade
-- local nvim_lsp = require("lspconfig")
-- TypeScript LSP
nvim_lsp.tsserver.setup {
  on_attach = on_attach,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
  cmd = { "typescript-language-server", "--stdio" }
}
]]

-- prettier, run with :Prettier
-- currently the rules conflict with eslint, kinda annoying
--[[
require("prettier").setup {  -- disabled after nvim 0.11.0 upgrade
  bin = 'prettierd',
  filetypes = {
    "css",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "json",
    "scss",
    "less"
  }
}
]]
