local openai = require("model.providers.openai")
local ollama = require('model.providers.ollama')
local util = require("model.util")

local function input_if_selection(input, context)
  return context.selection and input or ''
end

require('model.providers.openai').initialize({
    model = 'gpt-4-1106-preview'
})

require("model").setup({
  prompts = {},
  default_prompt = {
      provider = openai,
  },
  chats = {
    gpt4 = {
      provider = openai,
      system = 'You are a helpful assistant',
      params = {
        model = 'gpt-4'
      },
      create = input_if_selection,
      run = function(messages, config)
        if config.system then
          table.insert(messages, 1, {
            role = 'system',
            content = config.system
          })
        end

        return { messages = messages }
      end
    },
    deepseek = {
        provider = ollama,
        params = {
          model = 'deepseek-coder'
        },
        builder = function(input)
          return {
            prompt = 'GPT4 Correct User: ' .. input .. '<|end_of_turn|>GPT4 Correct Assistant: '
          }
        end
    }
  },
  hl_group = "Comment",
  join_undo = true,
})

