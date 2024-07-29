-- Leader key
vim.g.mapleader = vim.keycode("<Space>")
vim.g.maplocalleader = vim.keycode("<Space>")

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Indentation
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
-- Characters
vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "␣",
    extends = "▶",
    precedes = "◀",
    -- eol = "⏎",
}
vim.opt.fillchars = {
    -- Remove the tilde symbols at the end of buffers
    eob = " ",
    -- For folding
    fold = " ",
    foldopen = "",
    foldsep = " ",
    foldclose = "",
}
-- Error bells
vim.opt.errorbells = false
-- Split
vim.opt.splitbelow = true
vim.opt.splitright = true
-- Scrolling
vim.opt.scrolloff = 8
-- Undo files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fs.joinpath(vim.fn.stdpath("data"), "undodir")
vim.opt.undofile = true
-- Wrap
vim.opt.linebreak = true
-- Highlight search
vim.opt.hlsearch = false
-- Cursor
vim.opt.guicursor = ""
-- Mouse
vim.opt.mouse = "a"
-- Load project-wise vim settings
vim.opt.exrc = true
-- Backspace issue
vim.opt.backspace = { "indent", "eol", "start" }
-- Clipboard
vim.opt.clipboard = { "unnamed", "unnamedplus" }
-- Termcolor
vim.opt.termguicolors = true
-- Buffers
vim.opt.hidden = true
-- Latex
vim.g.tex_flavor = "latex"
-- Syntax-highlight lua in vimscript
vim.g.vimsyn_embed = "l"
-- Increases signcolumn width for gitsigns and diagnostics
vim.opt.signcolumn = "auto:2"
-- Global status bar
vim.opt.laststatus = 3

-- Indentation
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Terminal
vim.keymap.set("n", "<Leader>vt", ":vsplit | terminal<CR>")
vim.keymap.set("n", "<Leader>vT", ":split | terminal<CR>")

-- Quickfix list
vim.keymap.set("n", "[q", "<cmd>cprevious<CR>")
vim.keymap.set("n", "]q", "<cmd>cnext<CR>")

-- Smart dd.
vim.keymap.set("n", "dd", function()
    if vim.api.nvim_get_current_line():match("^%s*$") then
        return '"_dd'
    else
        return "dd"
    end
end, { noremap = true, expr = true })

-- Move
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor in the same position while doing line-appending
vim.keymap.set("n", "J", "mzJ`z")

-- Center the cursor vertically when using C-u/d
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Paste over a selection without losing the paste register
vim.keymap.set("x", "<leader>p", [["_dP]])

vim.opt.background = "light"
vim.cmd.colorscheme("wildcharm")

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
    if vim.v.shell_error ~= 0 then
        error('Error cloning lazy.nvim:\n' .. out)
    end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    { -- You can easily change to a different colorscheme.
        -- Change the name of the colorscheme plugin below, and then
        -- change the command in the config to whatever the name of that colorscheme is.
        --
        -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
        'folke/tokyonight.nvim',
        tag = "v4.8.0",
        priority = 1000, -- Make sure to load this before all the other start plugins.
        init = function()
            -- Load the colorscheme here.
            -- Like many other themes, this one has different styles, and you could load
            -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
            vim.cmd.colorscheme 'tokyonight-day'
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        config = function()
            require('lualine').setup {
                options = {
                    icons_enabled = false,
                    disabled_filetypes = {
                        "NvimTree", "qf",
                    }
                },
                sections = {
                    lualine_a = {'mode'},
                    lualine_b = {'branch', 'diff'},
                    lualine_c = {'diagnostics'},
                    lualine_x = {'encoding', 'fileformat', 'filetype'},
                    lualine_y = {},
                    lualine_z = {'location'}
                },
                winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                        }
                    },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                        }
                    },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                extensions = {}
            }
        end
    },
    {
        "lewis6991/gitsigns.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        version = "v0.9.0",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = {
                        text = "▌", -- │
                    },
                    change = {
                        text = "▌", -- │
                    },
                    delete = {
                        text = "_",
                    },
                    topdelete = {
                        text = "‾",
                    },
                    changedelete = {
                        text = "~",
                    },
                },
                on_attach = function(bufnr)
                    local gs = require("gitsigns")

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "]c", bang = true })
                        else
                            gs.nav_hunk("next")
                        end
                    end, { desc = "next hunk" })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            vim.cmd.normal({ "[c", bang = true })
                        else
                            gs.nav_hunk("prev")
                        end
                    end, { desc = "prev hunk" })

                    -- Actions
                    map({ "n", "v" }, "<leader>hs", gs.stage_hunk, { desc = "stage hunk" })
                    map({ "n", "v" }, "<leader>hr", gs.reset_hunk, { desc = "reset hunk" })
                    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
                    map("n", "<leader>hp", gs.preview_hunk, { desc = "preview hunk" })
                    map("n", "<leader>hS", gs.stage_buffer, { desc = "stage buffer" })
                    map("n", "<leader>hR", gs.reset_buffer, { desc = "reset buffer" })
                    map("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end, { desc = "blame line" })
                end,
            })
        end,
    },
    {
        {
            "nvim-telescope/telescope.nvim",
            branch = "0.1.x",
            event = "VimEnter",
            dependencies = {
                { "nvim-lua/plenary.nvim" },
                { "nvim-telescope/telescope-fzf-native.nvim" },
                { "nvim-telescope/telescope-ui-select.nvim" },
            },
            config = function()
                local telescope = require("telescope")

                telescope.setup({
                    defaults = {
                        sorting_strategy = "ascending",
                        layout_config = {
                            prompt_position = "top",
                        },
                        file_ignore_patterns = {
                            ".git/",
                            "__pycache__",
                        },
                    },
                    extensions = {
                        ["ui-select"] = {
                            require("telescope.themes").get_cursor({}),
                        },
                    },
                })

                vim.keymap.set("n", "<Leader>ff", function()
                    require("telescope.builtin").find_files({ hidden = true })
                end, { desc = "Files" })
                vim.keymap.set("n", "<Leader>fb", function()
                    require("telescope.builtin").buffers({ previewer = false })
                end, { desc = "Buffers" })
                vim.keymap.set(
                    "n",
                    "<Leader>fc",
                    require("telescope.builtin").current_buffer_fuzzy_find,
                    { desc = "Current buffer" }
                )
                vim.keymap.set(
                    "n",
                    "<Leader>fg",
                    require("telescope.builtin").live_grep,
                    { desc = "Grep" }
                )
                vim.keymap.set("n", "<Leader>fG", function()
                    require("telescope.builtin").live_grep({ hidden = true })
                end, { desc = "Grep include hidden" })
                vim.keymap.set(
                    "n",
                    "<Leader>fh",
                    require("telescope.builtin").help_tags,
                    { desc = "Help tags" }
                )
                vim.keymap.set(
                    "n",
                    "<Leader>fk",
                    require("telescope.builtin").keymaps,
                    { desc = "Keys" }
                )
                vim.keymap.set(
                    "n",
                    "<Leader>f;",
                    require("telescope.builtin").commands,
                    { desc = "Command" }
                )
                vim.keymap.set(
                    "n",
                    "<Leader>fp",
                    require("telescope.builtin").command_history,
                    { desc = "Command history" }
                )
                vim.keymap.set(
                    "n",
                    "<Leader>fo",
                    require("telescope.builtin").resume,
                    { desc = "Resume" }
                )
                vim.keymap.set(
                    "n",
                    "<Leader>fa",
                    require("telescope.builtin").builtin,
                    { desc = "Built-ins" }
                )
            end,
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
            cond = function()
              return vim.fn.executable("cmake") == 1
            end,
            config = function()
                require("telescope").load_extension("fzf")
            end,
        },
        {
            "nvim-telescope/telescope-ui-select.nvim",
            config = function()
                require("telescope").load_extension("ui-select")
            end,
        },
    },
    {
        "nvim-tree/nvim-tree.lua",
        tag = "nvim-tree-v0.100.0",
        config = function()
            require("nvim-tree").setup({
                filters = {
                    custom = {
                        "^.git$",
                        -- python
                        ".venv",
                        "__pycache__",
                        "*.egg-info",
                        ".pytest_cache",
                        -- latex
                        "_minted-main",
                        "*.aux",
                        "*.bbl",
                        "*.blg",
                        "*.bcf",
                        "*.fdb_latexmk",
                        "*.fls",
                        "*.glo",
                        "*.ist",
                        "*.lof",
                        "*.log",
                        "*.lot",
                        "*.nav",
                        "*.snm",
                        "*.synctex(busy)",
                        "*.synctex.gz",
                        "*.toc",
                        "*.vrb",
                    },
                },
                renderer = {
                    add_trailing = true,
                    group_empty = true,
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = false,
                            git = false,
                        },
                    },
                },
            })
        end,
        keys = {
            {
                "<Leader>ve",
                "<cmd>NvimTreeToggle<CR>",
                mode = "n",
                desc = "Toggle file tree",
            },
        },
    },
})
