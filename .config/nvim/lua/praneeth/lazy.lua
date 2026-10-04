local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    {
        "nvim-lua/plenary.nvim",
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>pf", function()
                builtin.find_files({
                    hidden = true,
                })
            end)
            vim.keymap.set("n", "<C-p>", builtin.git_files)
            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({
                    search = vim.fn.input("Grep > "),
                })
            end)
        end,
    },

    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>a", function()
                harpoon:list():add()
            end)

            vim.keymap.set("n", "<C-e>", function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)

            vim.keymap.set("n", "<C-h>", function()
                harpoon:list():select(1)
            end)

            vim.keymap.set("n", "<C-t>", function()
                harpoon:list():select(2)
            end)

            vim.keymap.set("n", "<C-n>", function()
                harpoon:list():select(3)
            end)

            vim.keymap.set("n", "<C-s>", function()
                harpoon:list():select(4)
            end)
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    {
        "tpope/vim-fugitive",
    },
})
