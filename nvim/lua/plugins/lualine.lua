local HOME_FOLDER = vim.fn.expand("$HOME")
local FOLDER_ICON_MAP = {
    [HOME_FOLDER .. "/Nextcloud/Documents/Uni"] = " /",
    [HOME_FOLDER .. "/Nextcloud"] = "󰅟 /",
    [HOME_FOLDER .. "/CodeProjects"] = " /",
    [HOME_FOLDER] = "~/",
}

local function string_starts_with(str, start)
	return str:sub(1, #start) == start
end

local function show_path()
    local absolute_file_path = vim.fn.expand("%")
    local filename = vim.fn.expand("%:t")
    local absolute_folder_path = string.sub(absolute_file_path, 0, string.len(absolute_file_path) - string.len(filename))

    for folder, icon in pairs(FOLDER_ICON_MAP) do
        if string_starts_with(absolute_folder_path, folder) then
            return icon .. string.sub(absolute_folder_path, string.len(folder) + 2)
        end
    end

    return absolute_folder_path
end

---@param max_length number
---@param character string | nil
---@return function
local function truncate(max_length, character)
    character = character or "…"

    return function(text)
        if string.len(text) > max_length then
            return string.sub(text, 0, max_length - 1) .. character
        end
        return text
    end
end

local function show_file_size()
    local file = vim.fn.expand("%:p")
    local size = vim.fn.getfsize(file)
    if size == 0 or size == -1 or size == -2 then
        return ''
    end

    ---@type string
    local formatted = ""

    if size < 1024 then
        formatted = size .. 'bytes'
    elseif size < 1024 * 1024 then
        formatted = string.format('%.1f',size/1024) .. 'KiB'
    elseif size < 1024 * 1024 * 1024 then
        formatted = string.format('%.1f',size/1024/1024) .. 'MiB'
    else
        formatted = string.format('%.1f',size/1024/1024/1024) .. 'GiB'
    end

    return formatted .. ' '
end

local function show_file_permissions()
    local file = vim.fn.expand("%:p")
    return vim.fn.getfperm(file)
end

return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "arkav/lualine-lsp-progress",
    },
    event = "VeryLazy",
    opts = {
        options = {
            icons_enabled = true,
            component_separators = "|",
            theme = "auto",
            section_separators = {
                left = "",
                right = "",
            },
        },
        sections = {
            lualine_a = {
                "mode",
            },
            lualine_b = {
                "branch",
                "diff",
                "diagnostics",
            },
            lualine_c = {
                "filename",
                show_path,
            },
            lualine_x = {
                show_file_permissions,
                show_file_size,
                "encoding",
                "fileformat",
                "filetype",
            },
            lualine_y = {
                "copilot",
                {
                    "lsp_progress",
                    fmt = truncate(20),
                }
            },
            lualine_z = {
                "progress",
                "location",
            }
        },
    },
}
