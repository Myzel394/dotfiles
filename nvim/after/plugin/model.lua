local openai = require("model.providers.openai")
local ollama = require("model.providers.ollama")
local mode = require("model").mode

local function input_if_selection(input, context)
  return context.selection and input or ""
end

require("model.providers.openai").initialize({
    model = "gpt-4-1106-preview"
})

require("model").setup({
    default_prompt = {
        provider = openai,
    },
    prompts = {
        ["regex_from_example"] = {
            provider = ollama,
            params = {
                model = "dolphin-phi"
            },
            builder = function(input)
                return {
                    prompt =
                        "I want you to act as a regex generator. " ..
                        "Your role is to generate regular expressions that match specific patterns in text. " ..
                        "You should provide the regular expressions in a format that can be easily copied " ..
                        "and pasted into a regex-enabled text editor or programming language. " ..
                        "Do not write explanations or examples of how the regular expressions work; " ..
                        "simply provide only the regular expressions themselves. " ..
                        "You will be given an example of a value that the regex should match against. " ..
                        "Generalize the regex. " ..
                        "For example, if you see a URL as an example, " ..
                        "it makes sense to provide a regex that matches an URL." ..
                        "\n\nThis is the user input: " .. input ..
                        "\n\nHere's the raw regex: "
                }
            end,
        },
        ["generate_commit_message"] = {
            provider = openai,
            mode = mode.INSERT,
            builder = function()
                local git_diff = vim.fn.system {"git", "diff", "--staged"}

                return {
                    messages = {
                        {
                            role = "system",
                            content =
                                "You are an expert at writing commit messages and you are a senior software developer with over 30 years of experience." ..
                                "Write a short commit message according to the Conventional Commits " ..
                                "specification for the following git diff: " ..
                                "```\n" .. git_diff .. "\n```. " ..
                                -- "These are the last 5 commit messages, you can take them as a reference: " ..
                                -- "\n```\n" .. title_history .. "\n```. " ..
                                "Don't include backticks in your response, only give the raw commit message. "
                        }
                    }
                }
            end,
        },
    },
    chats = {
        gpt4 = {
            provider = openai,
            system = "You are a helpful assistant",
            params = {
                model = "gpt-4"
            },
            create = input_if_selection,
            run = function(messages, config)
                if config.system then
                    table.insert(
                        messages,
                        1,
                        {
                            role = "system",
                            content = config.system
                        }
                    )
                end

                return { messages = messages }
            end
        },
        deepseek = {
            provider = ollama,
            create = input_if_selection,
            params = {
                model = "deepseek-coder"
            },
            system = "You are an intelligent programming assistant",
            run = function(messages, config)
                local prompt = "### System Prompt\n" .. config.system

                for _,msg in ipairs(messages) do
                    prompt =
                    prompt
                    .. "\n\n### "
                    .. (msg.role == "user" and "User Message" or "Assistant")
                    .. "\n"
                    .. msg.content
                end

                prompt = prompt .. "### Assistant\n"

                return {
                    prompt = prompt
                }
            end
        },
    },
    hl_group = "Comment",
    join_undo = true,
})

vim.keymap.set("n", "<leader>cc", ":Mchat<CR>", { silent = true, desc = "Chat with the AI" })
vim.keymap.set("n", "<leader>cd", ":Mdelete <CR>", { silent = true, desc = "Delete response under cursor" })
vim.keymap.set("n", "<leader>cs", ":Mselect <CR>", { silent = true, desc = "Select response under cursor" })
vim.keymap.set("n", "<leader>ct", ":Mcancel <CR>", { silent = true, desc = "Cancel response" })

vim.keymap.set({"n", "v"}, "<leader>cpd", ":Mchat deepseek<CR>", { silent = true, desc ="Chat with DeepSeek" })
vim.keymap.set({"n", "v"}, "<leader>cpg", ":Mchat gpt4<CR>", { silent = true, desc ="Chat with GPT4" })

vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "COMMIT_EDITMSG",
    callback = function()
        vim.cmd("M generate_commit_message")
    end,
})
