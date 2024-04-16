local function list_all_files(folder)
    local files = {}
    local pfile = io.popen("ls -1 " .. folder)

    if pfile == nil then
        return files
    end

    for file in pfile:lines() do
        -- if endswith ".jar"
        if file:sub(-4) == ".jar" then
            table.insert(files, folder .. "/" .. file)
        end
    end

    pfile:close()

    print(vim.inspect(files))
    return files
end

-- require "jdtls".start_or_attach {
--     cmd = {
--         "jdtls",
--         "--module-path " .. vim.fn.expand("$HOME") .. "/eclipse-workspace/_libraries/lib",
--         "--add-modules javafx.controls,javafx.fxml,javafx.graphics,javafx.web",
--     },
--     settings = {
--         java = {
--             project = {
--                 referencedLibraries = list_all_files(vim.fn.expand("$HOME") .. "/eclipse-workspace/_libraries/lib"),
--             }
--         }
--     }
-- }
