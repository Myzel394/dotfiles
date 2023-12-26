local galaxyline = require"galaxyline"
local fileinfo = require"galaxyline.provider_fileinfo"
local condition = require 'galaxyline.condition'
local vcs = require 'galaxyline.provider_vcs'
local diagnostic =require"galaxyline.provider_diagnostic"

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
    darkblue_bg  = "#1a2a3e",
    darkblue_bg2 = "#0f1a29",
    fg_darkblue  = "#71b9ff",
    blue         = "#3456c0",
    limegreen    = "#bbe67e",
    green        = "#2e8041",
    green_bg     = "#153622",
    green_bg2    = "#0a1a11",
    fg_green     = "#75c390",
    creamygreen  = "#a3be8c",
    yellow       = "#cccc00",
    creamyorange = "#ff8800",
    orange       = "#CC6600",
    orange_bg    = "#662600",
    orange_bg2   = "#220300",
    fg_orange    = "#FFAA00",
    bg           = "#000B0C15",
    fg           = "#D8DEE9",
    magenta      = "#a658ad",
    magenta_bg   = "#622268",
    magenta_bg2  = "#220022",
    fg_magenate  = "#e198e4",
    red          = "#df8890",
    crimsonRed   = "#990000",
    crimsonRed2  = "#ff4d4d",
    crimsonRed2_bg= "#742323",
    crimsonRed2_bg2= "#220000",
    fg_crimsonRed2= "#ff9d9d",
    greenYel     = "#EBCB8B",
    white        = "#d8dee9",
    brown        = "#91684a",
    teal         = '#23D4AC',
    blue2        = '#5c5c81',
    icon_inactive= '#9896AA'
}

local mode_name_map = {
    n      = "normal",
    no     = "normal",
    i      = "insert",
    ic     = "insert",
    c      = "command",
    ce     = "command",
    cv     = "command",
    v      = "visual",
    V      = "visual",
    ["␖"]  = "visual",
    R      = "replace",
    ['r?'] = "replace",
    Rv     = "replace",
    r      = "replace",
    rm     = "replace",
    s      = "select",
    S      = "select",
    ['␓']  = "select",
    t      = "terminal",
}

local mode_color_map = {
    normal = colors.bg_alt,
    insert = colors.green,
    command = colors.orange,
    visual = colors.darkblue,
    replace = colors.crimsonRed2,
    select = colors.greenYelenYel,
    terminal = colors.magenta,
}

local mode_color_bg_map = {
    insert = colors.green_bg,
    command = colors.orange_bg,
    visual = colors.darkblue_bg,
    replace = colors.crimsonRed2_bg,
    select = colors.greenYelenYel_bg,
    terminal = colors.magenta_bg,
}
local mode_color_bg2_map = {
    -- Transparent colors do not seem to be working
    -- insert = colors.green_bg2,
    -- command = colors.orange_bg2,
    -- visual = colors.darkblue_bg2,
    -- replace = colors.crimsonRed2_bg2,
    -- select = colors.greenYelenYel_bg2,
    -- terminal = colors.magenta_bg2,
}
local mode_color_fg_map = {
    normal = colors.oncreamydark,
    insert = colors.fg_green,
    command = colors.fg_orange,
    visual = colors.fg_darkblue,
    replace = colors.fg_crimsonRed2,
    select = colors.fg_greenYelenYel,
    terminal = colors.fg_magenta,
}

local mode_icon_map = {
    normal = icons.normal,
    insert = icons.insert,
    command = icons.command,
    visual = icons.visual,
    replace = icons.replace,
    select = icons.selection,
    terminal = icons.terminal,
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

local function mode_label()
    local mode_name = mode_name_map[vim.fn.mode()]

    return (mode_icon_map[mode_name] .. " " .. mode_name:upper()) or "N/A"
end
local function mode_hl()
    local mode_name = mode_name_map[vim.fn.mode()]

    return mode_color_map[mode_name] or colors.main
end
local function mode_hl_bg()
    local mode_name = mode_name_map[vim.fn.mode()]

    return mode_color_bg_map[mode_name] or colors.main_bg
end
local function mode_hl_bg2()
    local mode_name = mode_name_map[vim.fn.mode()]

    return mode_color_bg2_map[mode_name] or colors.bg
end
local function mode_hl_fg()
    local mode_name = mode_name_map[vim.fn.mode()]

    return mode_color_fg_map[mode_name] or colors.main
end


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
    return true
    -- local squeeze_width  = vim.fn.winwidth(0) / 2
    -- if squeeze_width > 40 then
    --     return true
    -- end
    -- return false
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
    -- if (require("galaxyline.condition").check_git_workspace()) and checkwidth() then
    --     local git_dir = require("galaxyline.provider_vcs").get_git_dir(vim.fn.expand("%:p"))
    --     local current_dir = vim.fn.expand("%:p:h")
    --     if git_dir == current_dir .. "/.git" or git_dir == nil then
    --         return fname
    --     end
    --     local get_path_from_git_root = current_dir:sub(#git_dir - 3)
    --     return get_path_from_git_root .. "/" .. fname
    -- end
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

vim.api.nvim_command('hi StatusLine guibg=' .. mode_hl_bg2() .. ' gui=nocombine')

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
            return string.format(' %s ', mode_label())
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
            highlight2('SecondaryGalaxyViModeBackgroundSeparator', mode_hl_bg(), colors.white, "none")
            return ""
        end,
        separator = "",
        highlight = "SecondaryGalaxyViModeBackgroundSeparator"
    }
}

galaxyline.section.left[7] = {
    FileSize = {
        provider = function()
            highlight2('SecondaryGalaxyViModeBackground', mode_hl_bg(), mode_hl_fg(), "none")

            return "  " .. (fileinfo.get_file_size() or "Empty file ") .. ""
        end,
        highlight = "SecondaryGalaxyViModeBackground"
    }
}
galaxyline.section.left[8] = {
    FileEncoding = {
        provider = function()
            return " " .. fileinfo.get_file_encode() .. "  "
        end,
        highlight = "SecondaryGalaxyViModeBackground"
    }
}

local CACHED_info = nil
galaxyline.section.left[9] = {
    SpacesInfo = {
        provider = function()
            local DIRS = {"."}

            if condition.check_git_workspace() then
                table.insert(DIRS, get_git_root_directory())
            end

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

            local function getSpacesInfo()
                if CACHED_info then
                    return CACHED_info
                end

                for _, dir in ipairs(DIRS) do
                    local info = getInfo(dir)

                    if info then
                        CACHED_info = info
                        return "Spaces: " .. info .. "  "
                    end
                end
            end

            return getSpacesInfo()
        end,
        highlight = "SecondaryGalaxyViModeBackground"
    }
}
galaxyline.section.left[10] = {
    LineInfo = {
        provider = "LineColumn",
        highlight = "SecondaryGalaxyViModeBackground"
    }
}
galaxyline.section.left[11] = {
    rightSep = {
        -- must be in normal mod
        condition = function()
            return vim.fn.mode() == 'n'
        end,
        provider = function()
            highlight2("SecondaryGalaxyViModeLastSeparator", colors.bg, mode_hl_bg(), "none")
            return ""
        end,
        separator = "",
        highlight = "SecondaryGalaxyViModeLastSeparator"
    }
}

galaxyline.section.left[12] = {
    DiagnosticError = {
        provider = function()
            local error = diagnostic.get_diagnostic_error()

            if error and tonumber(error) then
                return "  " .. " " .. error .. " "
            end
        end,
        highlight = {colors.crimsonRed, colors.bg}
    }
}
galaxyline.section.left[13] = {
    DiagnosticWarn = {
        provider = function()
            local warn = diagnostic.get_diagnostic_warn()

            if warn and tonumber(warn) then
                return "  " .. "󰈅 " .. warn .. " "
            end
        end,
        highlight = {colors.yellow, colors.bg}
    }
}
local HOME_FOLDER = vim.fn.expand("$HOME")
galaxyline.section.left[14] = {
    FullFileFolder = {
        provider = function()
            highlight2("FullFileFolderColor", mode_hl_bg2(), colors.oncreamydark, "none")
            local absolute_file_path = vim.fn.expand('%')
            local filename = vim.fn.expand('%:t')
            local absolute_folder_path = string.sub(
                absolute_file_path,
                0,
                string.len(absolute_file_path) - string.len(filename)
            )

            local home_folder_len = string.len(HOME_FOLDER)
            if string.sub(absolute_folder_path, 0, home_folder_len) == HOME_FOLDER then
                return "~" .. string.sub(absolute_folder_path, home_folder_len + 1)
            end

            return absolute_folder_path
        end,
        highlight = "FullFileFolderColor",
        icon = "  "
    }
}

galaxyline.section.right[1] = {
    LeftRoundedGit = {
        provider = function()
            return ""
        end,
        condition = condition.check_git_workspace,
        highlight = "SecondaryGalaxyViModeLastSeparator"
    }
}
galaxyline.section.right[2] = {
    DiffAdd = {
        provider = function()
            highlight2("DiffAddColor", mode_hl_bg(), colors.oncreamydark_green, "none")
            return "󰐕" .. " " .. (vcs.diff_add() or "0 ")
        end,
		condition = condition.check_git_workspace,
        highlight = "DiffAddColor"
    }
}
galaxyline.section.right[3] = {
    DiffModify = {
        provider = function()
            highlight2("DiffModifyColor", mode_hl_bg(), colors.oncreamydark_blue, "none")
            return "󰜥" .. " " .. (vcs.diff_modified() or "0 ")
        end,
        condition = condition.check_git_workspace,
        highlight = "DiffModifyColor"
    }
}
galaxyline.section.right[4] = {
    DiffRemove = {
        provider = function()
            highlight2("DiffRemoveColor", mode_hl_bg(), colors.oncreamydark_red, "none")
            return "󰍴" .. " " .. (vcs.diff_remove() or "0 ")
        end,
        condition = condition.check_git_workspace,
        highlight = "DiffRemoveColor"
    }
}
-- Only show stages amount at the beginning of the file as it's very slow
-- DOESN'T SEEM TO BE WORKING! :(
-- local CACHED_HAS_SHOWN_STAGED = false
-- galaxyline.section.right[5] ={
--     GitStagedfFilesAmount = {
--         provider = function()
--             if CACHED_HAS_SHOWN_STAGED then
--                 return
--             end
--
--             CACHED_HAS_SHOWN_STAGED = true
--             return " | " .. "" .. " " .. get_git_staged_files_amount() .. "/" .. get_git_modified_files_amount() .. " "
--         end,
--         condition = check_git_terminal_workspace,
--         highlight = {colors.oncreamydark, colors.creamydark}
--     }
-- }
galaxyline.section.right[6] = {
    GitBranchSeparator = {
        provider = function()
            highlight2('GitBranchSeparator', mode_hl_bg(), mode_hl(), 'bold')
        end,
        separator = "",
		condition = condition.check_git_workspace,
        separator_highlight = 'GitBranchSeparator'
    }
}
galaxyline.section.right[7] = {
	GitBranchName = {
		condition = condition.check_git_workspace,
		provider = function()
			local branch = vcs.get_git_branch()
			local name = branch and branch:gsub('detached at ', '') or ''

            return " " .. "󰘬" .. " " .. string.format("%s", name) .. " "
		end,
        highlight = "GalaxyViMode",
    }
}
galaxyline.section.right[8] = {
    RightEnd = {
        provider = function()
            return ""
        end,
		condition = condition.check_git_workspace,
        highlight = 'GalaxyViModeInv'
    }
}

