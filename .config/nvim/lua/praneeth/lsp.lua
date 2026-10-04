local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.diagnostic.config({
    virtual_text = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

vim.keymap.set("n", "[d", function()
    vim.diagnostic.jump({ count = -1 })
end)

vim.keymap.set("n", "]d", function()
    vim.diagnostic.jump({ count = 1 })
end)

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(event)
        local opts = { buffer = event.buf }

        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)

        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

        vim.keymap.set(
            { "n", "v" },
            "<leader>ca",
            vim.lsp.buf.code_action,
            opts
        )
    end,
})

vim.lsp.config("lua_ls", {
    capabilities = capabilities,

    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },

            diagnostics = {
                globals = {
                    "vim",
                },
            },

            workspace = {
                library = {
                    vim.env.VIMRUNTIME,
                },
            },

            telemetry = {
                enable = false,
            },
        },
    },
})

vim.lsp.config("ts_ls", {
    capabilities = capabilities,
})

vim.lsp.config("gopls", {
    capabilities = capabilities,
})

vim.lsp.config("rust_analyzer", {
    capabilities = capabilities,
})

vim.lsp.config("clangd", {
    capabilities = capabilities,
})

vim.lsp.config("pyright", {
    capabilities = capabilities,
})

vim.lsp.enable({
    "lua_ls",
    "ts_ls",
    "gopls",
    "rust_analyzer",
    "clangd",
    "pyright",
})
