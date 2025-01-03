local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  enabled = not RUNNING_LIMITED_HARDWARE,
  build = "make",
  opts = {
    provider = "openai",
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below is optional, make sure to setup it properly if you have lazy=true
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
