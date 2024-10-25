local RUNNING_LIMITED_HARDWARE = os.getenv("DOTFILES_RUNNING_ON_LIMITED_HARDWARE") == "1"

return {
  "folke/neodev.nvim",
  enabled = not RUNNING_LIMITED_HARDWARE,
  opts = {
    override = function(root_dir, library)
      if root_dir:find("~/CodeProjects/", 1, true) == 1 then
        library.enabled = true
        library.plugins = true
      end
    end,
  },
}

