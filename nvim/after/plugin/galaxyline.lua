local galaxyline = require"galaxyline"
local fileinfo = require"galaxyline.provider_fileinfo"
local condition = require 'galaxyline.condition'
local vcs = require 'galaxyline.provider_vcs'

galaxyline.short_line_list = {'plug', 'fugitive', 'NvimTree', 'vista', 'dbui', 'packer', 'startify', 'coc'}

local icons = {
    sep = {
        right = "",
        left = ""
    },
    diagnostic = {
        error = " ",
        warn = " ",
        info = " "
    },
    diff = {
        add = " ",
        modified = " ",
        remove = " "
    },
    git = "󰘬",
    line_nr = "",
    file = {
      read_only = '',
      modified = '',
    },
    normal    = "",
    insert    = "",
    command   = "",
    visual    = "󰒉",
    replace   = "󰗧",
    selection = "󰕩",
    terminal  = "",
    visual_block = "󰒉"
}

local colors = {
    main         = "#ff87ff",
    bg_alt       = "#0B0C15",
    main_bg      = "#262626",
    lightbg      = "#21252B",
    commented    = "#5c6370",
    grey         = "#3c4048",
    line_bg      = "#282c34",
    creamydark   = "#282c34",
    oncreamydark = "#7b828f",
    -- a little bit green
    oncreamydark_green = "#7b966f",
    -- a little bit blue
    oncreamydark_blue = "#7b80bf",
    -- a little bit red
    oncreamydark_red = "#966f7b",
    purple       = "#252930",
    cyan         = "#00FFFF",
    nord         = "#81A1C1",
    lightblue    = "#81a1c1",
    darkblue     = "#215f9f",
    blue         = "#3456c0",
    limegreen    = "#bbe67e",
    green        = "#2e8041",
    fg_green     = "#65a380",
    creamygreen  = "#a3be8c",
    yellow       = "#cccc00",
    creamyorange = "#ff8800",
    orange       = "#CC6600",
    bg           = "#000B0C15",
    fg           = "#D8DEE9",
    magenta      = "#a658ad",
    red          = "#df8890",
    crimsonRed   = "#990000",
    crimsonRed2  = "#ff4d4d",
    greenYel     = "#EBCB8B",
    white        = "#d8dee9",
    brown        = "#91684a",
    teal         = '#23D4AC',
    blue2        = '#5c5c81',
    icon_inactive= '#9896AA'
}

local mode_map = {
    -- n      = {" NORMAL  ", colors.red},
    -- i      = {" INSERT  ", colors.green},
    -- c      = {" COMMAND ", colors.orange},
    -- v      = {" VISUAL  ", colors.lightblue},
    n      = {icons.normal    .. "  NORMAL  ", colors.bg_alt},
    no     = {icons.normal    .. "  NORMAL  ", colors.bg_alt},
    i      = {icons.insert    .. "  INSERT  ", colors.green},
    ic     = {icons.insert    .. "  INSERT  ", colors.green},
    c      = {icons.command   .. "  COMMAND ", colors.orange},
    ce     = {icons.command   .. "  COMMAND ", colors.orange},
    cv     = {icons.command   .. "  COMMAND ", colors.orange},
    v      = {icons.visual    .. "  VISUAL  ", colors.darkblue},
    V      = {icons.visual    .. "  VISUAL  ", colors.darkblue},
    ["␖"] = {icons.visual    .. "  VISUAL" .. icons.visual_block .. " ", colors.brown},
    R      = {icons.replace   .. "  REPLACE ", colors.crimsonRed2},
    ['r?'] = {icons.replace   .. "  REPLACE ", colors.lightblue},
    Rv     = {icons.replace   .. "  REPLACE ", colors.crimsonRed2},
    r      = {icons.replace   .. "  REPLACE ", colors.blue2},
    rm     = {icons.replace   .. "  REPLACE ", colors.blue2},
    s      = {icons.selection .. "  SELECT  ", colors.greenYelenYel},
    S      = {icons.selection .. "  SELECT  ", colors.greenYelenYel},
    ['␓'] = {icons.selection .. "  SELECT  ", colors.greenYelenYel},
    t      = {icons.terminal  .. "  TERMINAL ", colors.magenta},
    ['!']  = {                  "  !        ", colors.crimsonRed}
}

---------- Functions ----------
local function get_git_staged_files_amount()
    local command = "git diff --name-only --staged | wc -l | sed 's/ //g'"
    local process = io.popen(command, "r")

    if not process then return "0" end

    local count_raw = process:read("a")
    process:close()
    local count = tonumber(count_raw)

    return (count or 0) .. ""
end

local function get_git_modified_files_amount()
    local command = "git diff --name-only | wc -l | sed 's/ //g'"
    local process = io.popen(command, "r")

    if not process then return "0" end

    local count_raw = process:read("a")
    process:close()
    local count = tonumber(count_raw)

    return (count or 0) .. ""
end

local function get_git_root_directory()
    local command = "git rev-parse --show-toplevel"
    local process = io.popen(command, "r")

    if not process then return end

    local git_root = process:read("a")
    process:close()

    return git_root
end

local PRETTIER_CONFIG_FILES = {
    ".prettierrc",
    ".prettierrc.json",
    ".prettierrc.yml",
    ".prettierrc.yaml",
    ".prettierrc.js",
    ".prettierrc.cjs",
    ".prettierrc.config.js",
    ".prettierrc.config.cjs",
    "prettier.config.js",
    "prettier.config.cjs",
    "prettier.config.ts",
    "prettier.config.mjs",
    "prettier.config.coffee",
    "prettier.config.toml",
    "prettier.config.json",
    "prettier.config.yaml",
    "prettier.config.yml",
    "prettier.config.cjson",
    "prettier.config.cyaml",
    "prettier.config.json5",
    "prettier.config.jsonc",
}

local function extract_prettier_config(directory, pattern)
    -- iterate over table
    for _, file in ipairs(PRETTIER_CONFIG_FILES) do
        local file_path = directory .. "/" .. file
        local file_exists = vim.fn.filereadable(file_path) == 1
        if file_exists then
            local file_handle = io.open(file_path, "r")

            if file_handle then
                local file_content = file_handle:read("*a")
                file_handle:close()

                local match = string.match(file_content, pattern)
                if match then 
                    return match
                end
            end
        end
    end
end

local function mode_label() return mode_map[vim.fn.mode()][1] or 'N/A' end
local function mode_hl() return mode_map[vim.fn.mode()][2] or colors.main end

local function highlight1(group, fg, gui)
    local cmd = string.format('highlight %s guifg=%s', group, fg)
    if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
    vim.cmd(cmd)
end

local function highlight2(group, bg, fg, gui)
    local cmd = string.format('highlight %s guibg=%s guifg=%s', group, bg, fg)
    if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
    vim.cmd(cmd)
end

local function get_coc_lsp()
    local f, status = pcall(vim.api.nvim_get_var, 'coc_status')
    if not f or status == '' then
        return nil
    else
        return status
    end
end

local function get_diagnostic_info()
    if vim.fn.exists('*coc#rpc#start_server') == 1 then
        return get_coc_lsp()
    end
    return nil
end

local function get_current_func()
    local has_func, func_name = pcall(vim.api.nvim_buf_get_var, 0, 'coc_current_function')
    if not has_func then return nil end
    return func_name
end

local function get_function_info()
    if vim.fn.exists('*coc#rpc#start_server') == 1 then
        return get_current_func()
    end
    return ''
end

local function buffer_not_empty()
	return #vim.fn.expand('%:t') > 0
end

---@param width integer
local function window_wider_than(width)
	return vim.fn.winwidth(0) >= width
end

CocStatus = get_diagnostic_info
CocFunc = get_function_info

local checkwidth = function()
    local squeeze_width  = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

local function file_name(is_active, highlight_group)
    local normal_fg = is_active and colors.creamydark or colors.blue2
    local modified_fg = colors.darkblue
    if vim.bo.modifiable then
        if vim.bo.modified then
            vim.api.nvim_command('hi ' .. highlight_group .. ' guifg='.. modified_fg .. ' gui=bold')
        else
            vim.api.nvim_command('hi ' .. highlight_group .. ' guifg='.. normal_fg .. ' gui=NONE')
        end
    end
    local fname = fileinfo.get_current_file_name(icons.file.modified, icons.file.read_only)
    if (require("galaxyline.condition").check_git_workspace()) and checkwidth() then
        local git_dir = require("galaxyline.provider_vcs").get_git_dir(vim.fn.expand("%:p"))
        local current_dir = vim.fn.expand("%:p:h")
        if git_dir == current_dir .. "/.git" or git_dir == nil then
            return fname
        end
        local get_path_from_git_root = current_dir:sub(#git_dir - 3)
        return get_path_from_git_root .. "/" .. fname
    end
    return fname
end

local white_space = function() return ' ' end

local function trailing_whitespace()
    local trail = vim.fn.search("\\s$", "nw")
    if trail ~= 0 then
        return ' '
    else
        return nil
    end
end

local TrailingWhiteSpace = trailing_whitespace

local check_git_width = function()
    return checkwidth() and require("galaxyline.condition").check_git_workspace()
end

local check_git_terminal_workspace = function()
    return not (vim.fn.mode() == 't') and require("galaxyline.condition").check_git_workspace()
end

galaxyline.section.left[1] = {
    leftRounded = {
        provider = function()
            return ""
        end,
        highlight = 'GalaxyViModeInv'
    }
}
galaxyline.section.left[2] = {
    ViMode = {
        provider = function()
            highlight2('GalaxyViMode', mode_hl(), colors.fg, 'bold')
            highlight1('GalaxyViModeInv', mode_hl(), 'bold')
            return string.format(' %s', mode_label())
        end,
    }
}

galaxyline.section.left[3] = {
    WhiteSpace = {
        provider = function()
            highlight2('SecondGalaxyViMode', mode_hl(), colors.white, 'bold')
        end,
        separator = "",
        separator_highlight = 'SecondGalaxyViMode'
    }
}
galaxyline.section.left[4] = {
	FileIconFile = {
        provider = function()
            return fileinfo.get_file_icon()
        end,
        highlight = {colors.creamydark, colors.white}
   }
}
galaxyline.section.left[5] = {
    FileName = {
        provider = function() return file_name(true, 'GalaxyFileName') end,
        highlight = {colors.creamydark, colors.white},
    }
}
galaxyline.section.left[6] = {
    teech = {
        provider = function()
            return ""
        end,
        separator = "",
        highlight = {colors.white, colors.creamydark}
    }
}

galaxyline.section.left[7] = {
    FileEncoding = {
        provider = function()
            return " " .. fileinfo.get_file_encode() .. " "
        end,
        highlight = {colors.oncreamydark, colors.creamydark},
    }
}
galaxyline.section.left[8] = {
    FileSize = {
        provider = function()
            return "| " .. fileinfo.get_file_size() .. "|"
        end,
		condition = function()
			return buffer_not_empty() and vim.bo.buftype ~= 'terminal' and window_wider_than(60)
		end,
        highlight = {colors.oncreamydark, colors.creamydark},
    }
}
galaxyline.section.left[9] = {
    SpacesInfo = {
        provider = function()
            local DIRS = {".", get_git_root_directory()}

            local function getInfo(directory)
                local useTabs_raw = extract_prettier_config(directory, "[\"']useTabs[\"']:%s*(%w*)")

                if useTabs_raw then
                    if useTabs_raw == "true" then
                        return "TABS 󰌒 "
                    end
                end

                local spacesAmount_raw = extract_prettier_config(directory, "[\"']tabWidth[\"']:%s*(%d+)")
                if spacesAmount_raw then
                    local spacesAmount_numbers_raw = string.match(spacesAmount_raw, "%d+")
                    local spacesAmount = tonumber(spacesAmount_numbers_raw)

                    if spacesAmount == 2 then
                        return "2"
                    elseif spacesAmount == 4 then
                        return "4"
                    elseif spacesAmount == 8 then
                        return "8"
                    end
                end
            end

            for _, dir in ipairs(DIRS) do
                local info = getInfo(dir)

                if info then
                    return " | " .. "Spaces: " .. info
                end
            end
        end,
        highlight = {colors.oncreamydark, colors.creamydark},
    }
}
galaxyline.section.left[10] = {
    LineInfo = {
        provider = "LineColumn",
        icon = " ",
        highlight = {colors.oncreamydark, colors.creamydark},
    }
}
galaxyline.section.left[11] = {
    rightSep = {
        provider = function()
            return ""
        end,
        separator = "",
        highlight = {colors.creamydark, colors.bg}
    }
}

galaxyline.section.right[1] = {
    LeftRoundedGit = {
        provider = function()
            return ""
        end,
        condition = condition.check_git_workspace,
        highlight = {colors.creamydark, colors.bg}
    }
}
galaxyline.section.right[2] = {
    DiffAdd = {
        provider = function()
            return "󰐕" .. " " .. (vcs.diff_add() or '0') .. " "
        end,
		condition = condition.check_git_workspace,
        highlight = {colors.oncreamydark_green, colors.creamydark}
    }
}
galaxyline.section.right[3] = {
    DiffModified = {
        provider = function()
            return "󰜥" .. " " .. (vcs.diff_modified() or '0') .. " "
        end,
        condition = condition.check_git_workspace,
        highlight = {colors.oncreamydark_blue, colors.creamydark}
    }
}
galaxyline.section.right[4] = {
    DiffRemove = {
        provider = function()
            return "󰍴" .. " " .. (vcs.diff_remove() or '0') .. " "
        end,
        condition = condition.check_git_workspace,
        highlight = {colors.oncreamydark_red, colors.creamydark},

    }
}
galaxyline.section.right[5] ={
    GitStagedfFilesAmount = {
        provider = function()
            return " | " .. "" .. " " .. get_git_staged_files_amount() .. "/" .. get_git_modified_files_amount() .. " "
        end,
        condition = check_git_terminal_workspace,
        highlight = {colors.oncreamydark, colors.creamydark}
    }
}
galaxyline.section.right[6] = {
    GitBranchSeparator = {
        provider = function()
            highlight2('GitBranchSeparator', colors.creamydark, mode_hl(), 'bold')
        end,
        separator = "",
        separator_highlight = 'GitBranchSeparator'
    }
}
galaxyline.section.right[7] = {
	GitBranchName = {
		condition = condition.check_git_workspace,
		provider = function()
			local branch = require('galaxyline.provider_vcs').get_git_branch()
			local name = branch and branch:gsub('detached at ', '') or ''

            return "󰘬" .. " " .. string.format("%s", name)
		end,
        highlight = "GalaxyViMode",
    }
}
galaxyline.section.right[8] = {
    RightEnd = {
        provider = function()
            return ""
        end,
        highlight = 'GalaxyViModeInv'
    }
}

