; extends

(("const" @keyword.declaration) (#set! conceal ""))
(("let" @keyword.declaration) (#set! conceal ""))
(("export" @keyword.export.tsx) (#set! conceal "󰞕 "))
(("default" @keyword.tsx) (#set! conceal "󰮭 "))
(("function" @keyword.function.tsx) (#set! conceal "󰊕"))

(("async" @keyword.coroutine.tsx) (#set! conceal " "))
(("await" @keyword.coroutine.tsx) (#set! conceal " "))

(("return" @keyword.return.tsx) (#set! conceal ""))

(("break" @keyword.control.tsx) (#set! conceal "󰂭 "))
(("continue" @keyword.control.tsx) (#set! conceal ""))

(("import" @keyword.import.tsx) (#set! conceal "󰞒 "))
(("from" @keyword.import.tsx) (#set! conceal " "))

(("=>" @operator) (#set! conceal "󰧂 "))
(("??" @operator) (#set! conceal ""))
(("!==" @operator) (#set! conceal "󰦎"))
(("&&" @operator) (#set! conceal "∧"))
(("||" @operator) (#set! conceal "∨"))
((">=" @operator) (#set! conceal "≥"))
(("<=" @operator) (#set! conceal "≤"))

(("?" @keyword.conditional.ternary) (#set! conceal "¿"))

; (("null" @builtin) (#set! conceal "󰟢"))
(("try" @keyword.exception) (#set! conceal "󰿎 "))
(("catch" @keyword.exception) (#set! conceal "☇"))
(("finally" @keyword.exception) (#set! conceal "󰑆 "))

(("switch" @conditional) (#set! conceal "󰀁"))
(("case" @conditional) (#set! conceal "󰜴"))

; (("this" @keyword.builtin) (#set! conceal "a"))


; (template_substituion
;     (#eq? @punctuation.special "${")
;     (#set! conceal "")
; )

; (("[]" @punctuation.bracket) (#set! conceal "▯"))

; ((identifier) @function.call
;     (#eq? @function.call "useRef")
;     (#set! conceal "")
; )

(member_expression
  property: (property_identifier) @function.method.call
    (#eq? @function.method.call "map")
    (#set! conceal "")
)

(member_expression
  property: (property_identifier) @function.method.call
    (#eq? @function.method.call "filter")
    (#set! conceal " ")
)

(member_expression
  property: (property_identifier) @function.method.call
    (#eq? @function.method.call "reduce")
    (#set! conceal "󰁂")
)

(member_expression
  property: (property_identifier) @function.method.call
    (#eq? @function.method.call "join")
    (#set! conceal "󰡌 ")
)

(member_expression
  property: (property_identifier) @function.method.call
    (#eq? @function.method.call "forEach")
    (#set! conceal "󰞘 ")
)

(member_expression
  property: (property_identifier) @function.method.call
    (#eq? @function.method.call "find")
    (#set! conceal " ")
)

(member_expression
  property: (property_identifier) @function.method.call
    (#eq? @function.method.call "split")
    (#set! conceal "󰡎 ")
)

(member_expression
  property: (property_identifier) @variable.member
    (#eq? @variable.member "length")
    (#set! conceal " ")
)

(member_expression
  property: (property_identifier) @variable.member
    (#eq? @variable.member "current")
    (#set! conceal "")
)
