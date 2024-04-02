; extends

(("local" @keyword.lua) (#set! conceal "󰁃"))
(("function" @keyword.function.lua) (#set! conceal "󰊕"))

(("return" @keyword.return.lua) (#set! conceal ""))


(("if" @keyword.conditional.lua) (#set! conceal ""))
(("else" @keyword.conditional.lua) (#set! conceal ""))

(("while" @keyword.repeat) (#set! conceal "󰛤 "))
(("for" @keyword.repeat) (#set! conceal "󰛥 "))

(("~=" @keyword.operator.lua) (#set! conceal "󰦎"))
(("and" @keyword.operator.lua) (#set! conceal "∧"))
(("or" @keyword.operator.lua) (#set! conceal "∨"))
((">=" @keyword.operator.lua) (#set! conceal "≥"))
(("<=" @keyword.operator.lua) (#set! conceal "≤"))

(
    (function_call 
        name: (identifier) @function.builtin 
        (#eq? @function.builtin "require")
    ) 
    (#set! conceal "󰞒 ")
)
