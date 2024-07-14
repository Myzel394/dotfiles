return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function(opts)
            require("nvim-autopairs").setup()

            local Rule = require("nvim-autopairs.rule")
            local npairs = require("nvim-autopairs")
			local cond = require("nvim-autopairs.conds");

            npairs.add_rules({
                Rule(";$", ";")
                    :use_regex(true)
                    :with_move(cond.none()),
                Rule("u%d%d%d%d$", "number")
                    :use_regex(true)
            })

        end,
        -- use opts = {} for passing setup options
        -- this is equalent to setup({}) function
    }
}
