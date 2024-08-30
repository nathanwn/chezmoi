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
vim.cmd.packadd("cfilter")

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

local get_custom_theme = function()
    local M = {}

    M.palette = {
      red = "#af0000",
      light_red = "#FF8080",
      maroon = "#d70000",
      green = "#008700",
      light_green = "#80F080",
      pink = "#d70087",
      mauve = "#8700af",
      blue = "#005faf",
      yellow = "#806000",
      light_yellow = "#F0D060",
      sky = "#88aaff",
      teal = "#005f87",
      peach = "#772C29",
      rosewater = "#d04a00",
      flamingo = "#8700d7",
      sapphire = "#09735c",
      lavender = "#5566C0",
      text = "#444444",
      subtext1 = "#555555",
      subtext0 = "#666666",
      overlay2 = "#777777",
      overlay1 = "#888888",
      overlay0 = "#999999",
      surface2 = "#aaaaaa",
      surface1 = "#bbbbbb",
      surface0 = "#cccccc",
      base = "#eeeeee",
      mantle = "#dddddd",
      crust = "#cccccc",
    }

    M.custom_groups = {
      markdown_code_bg = M.palette.mantle,
    }

    --- You can override specific color groups to use other groups or a hex color
    --- function will be called with a ColorScheme table
    --- List of colors: https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_day.lua
    M.on_colors = function(colors)
      -- P(colors)
      colors.bg = M.palette.base
      colors.bg_dark = M.palette.mantle
      colors.bg_float = M.palette.mantle
      colors.bg_highlight = M.palette.surface1
      colors.bg_popup = M.palette.mantle
      colors.bg_search = M.palette.surface0
      colors.bg_sidebar = M.palette.mantle
      colors.bg_statusline = M.palette.mantle
      colors.bg_visual = M.palette.surface0
      colors.black = M.palette.surface0
      colors.blue = M.palette.blue
      colors.blue0 = M.palette.blue
      colors.blue1 = M.palette.blue
      colors.blue2 = M.palette.blue
      colors.blue5 = M.palette.blue
      colors.blue6 = M.palette.blue
      colors.blue7 = M.palette.blue
      colors.border = M.palette.blue
      colors.border_highlight = M.palette.sky
      colors.comment = M.palette.overlay1
      colors.cyan = M.palette.teal
      colors.dark3 = M.palette.subtext1
      colors.dark5 = M.palette.subtext0
      colors.delta = {
        add = M.palette.light_green,
        delete = M.palette.light_red,
      }
      colors.diff = {
        add = M.palette.light_green,
        change = M.palette.light_yellow,
        delete = M.palette.light_red,
        text = M.palette.sky,
      }
      colors.error = M.palette.red
      colors.fg = M.palette.text
      colors.fg_dark = M.palette.subtext0
      colors.fg_float = M.palette.subtext0
      colors.fg_gutter = M.palette.surface1
      colors.fg_sidebar = M.palette.text
      colors.git = {
        add = M.palette.green,
        change = M.palette.yellow,
        delete = M.palette.red,
        ignore = M.palette.sky,
      }
      colors.gitSigns = {
        add = M.palette.green,
        change = M.palette.yellow,
        delete = M.palette.red,
      }
      colors.green = M.palette.green
      colors.green1 = M.palette.green
      colors.green2 = M.palette.green
      colors.hint = M.palette.teal
      colors.info = M.palette.sky
      colors.magenta = M.palette.pink
      colors.magenta2 = M.palette.pink
      colors.none = M.palette.mantle
      colors.orange = M.palette.rosewater
      colors.purple = M.palette.mauve
      colors.red = M.palette.red
      colors.red1 = M.palette.maroon
      colors.teal = M.palette.teal
      colors.terminal_black = M.palette.overlay1
      colors.todo = M.palette.blue
      colors.warning = M.palette.yellow
      colors.yellow = M.palette.yellow
    end

    M.on_highlights = function(hl, c)
      hl["@markup.raw.markdown_inline"] = {
        fg = c.purple,
        bg = M.custom_groups.markdown_code_bg,
      }
      hl.Conceal = {
        fg = M.palette.red,
      }
      -- hl.DapUIPlayPause = {
      --   fg = M.palette.green,
      -- }
      -- hl.DapUIRestart = {
      --   fg = M.palette.green,
      -- }
      -- hl.DapUIStepOut = {
      --   fg = M.palette.blue,
      -- }
      -- hl.DapUIStepBack = {
      --   fg = M.palette.blue,
      -- }
      -- hl.DapUIStepInto = {
      --   fg = M.palette.blue,
      -- }
      -- hl.DapUIStepOver = {
      --   fg = M.palette.blue,
      -- }
      hl.DiagnosticVirtualTextError = {
        fg = c.error,
        bg = M.palette.mantle,
      }
      hl.DiagnosticVirtualTextHint = {
        fg = c.hint,
        bg = M.palette.mantle,
      }
      hl.DiagnosticVirtualTextInfo = {
        fg = c.info,
        bg = M.palette.mantle,
      }
      hl.DiagnosticVirtualTextOk = {
        fg = c.hint,
        bg = M.palette.mantle,
      }
      hl.DiagnosticVirtualTextWarn = {
        fg = c.warning,
        bg = M.palette.mantle,
      }
      hl.HeirlineBranch = {
        fg = M.palette.base,
        bg = M.palette.mauve,
      }
      hl.HeirlineFilenameActive = {
        fg = M.palette.blue,
        bg = M.palette.surface0,
      }
      hl.HeirlineFilenameInactive = {
        fg = M.palette.overlay2,
        bg = M.palette.surface0,
      }
      hl.HeirlineFiletype = {
        fg = M.palette.base,
        bg = M.palette.mauve,
      }
      hl.HeirlineLocation = {
        fg = M.palette.base,
        bg = M.palette.blue,
      }
      hl.HeirlineLsp = {
        fg = M.palette.base,
        bg = M.palette.lavender,
      }
      hl.HeirlineViModeNormal = {
        fg = M.palette.base,
        bg = M.palette.blue,
      }
      hl.HeirlineViModeInsert = {
        fg = M.palette.blue,
        bg = M.palette.base,
      }
      hl.HeirlineViModeVisual = {
        fg = M.palette.base,
        bg = M.palette.sapphire,
      }
      hl.HeirlineViModeReplace = {
        fg = M.palette.base,
        bg = M.palette.sky,
      }
      hl.HeirlineViModeCommand = {
        fg = M.palette.base,
        bg = M.palette.yellow,
      }
      hl.HeirlineViModeOther = {
        fg = M.palette.base,
        bg = M.palette.yellow,
      }
      hl["RenderMarkdownCode"] = {
        bg = M.custom_groups.markdown_code_bg,
      }
      hl.TelescopeBorder = {
        fg = M.palette.blue,
      }
      -- hl.LspInlayHint = {
      --   fg = M.palette.base,
      --   bg = M.palette.lavender,
      -- }
      -- hl.NvimTreeNormal = {
      --   bg = M.palette.mantle,
      -- }
      -- hl.NvimTreeExecFile = {
      --   fg = M.palette.pink,
      -- }
    end

    return M
end

local custom_theme = get_custom_theme()

require('lazy').setup({
    {
        "folke/tokyonight.nvim",
        tag = "v4.8.0",
        priority = 1000,
        init = function()
            require("tokyonight").setup({
              on_colors = custom_theme.on_colors,
              on_highlights = custom_theme.on_highlights,
            })
            vim.cmd.colorscheme("tokyonight-day")
        end,
    },
    {
        "uga-rosa/ccc.nvim",
        config = function()
            require("ccc").setup()
        end
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
