; extends

(("const" @keyword.declaration) (#set! conceal "󰁃"))
(("let" @keyword.declaration) (#set! conceal ""))
(("export" @keyword.export.tsx) (#set! conceal "󰞕 "))
(("default" @keyword.tsx) (#set! conceal "󰮭 "))
(("function" @keyword.function.tsx) (#set! conceal "󰊕"))

(("async" @keyword.coroutine.tsx) (#set! conceal ""))
(("await" @keyword.coroutine.tsx) (#set! conceal ""))

(("return" @keyword.return.tsx) (#set! conceal ""))

(("break" @keyword.control.tsx) (#set! conceal "󰂭 "))
(("continue" @keyword.control.tsx) (#set! conceal ""))

(("import" @keyword.import.tsx) (#set! conceal "󰞒 "))
(("from" @keyword.import.tsx) (#set! conceal " "))
(("as" @keyword.import.tsx) (#set! conceal " "))

(("if" @keyword.conditional.tsx) (#set! conceal ""))
(("else" @keyword.conditional.tsx) (#set! conceal ""))

; (("true" @keyword.builtin) (#set! conceal " "))
; (("false" @keyword.builtin) (#set! conceal " "))

; (("undefined" @keyword.builtin) (#set! conceal "󰟣"))
;
; (("true" @keyword.builtin) (#set! conceal "󰟦"))
; (("false" @keyword.builtin) (#set! conceal "󰟧"))
;
; (("this" @keyword.builtin) (#set! conceal "󰟨"))
; (("arguments" @keyword.builtin) (#set! conceal "󰟩"))

(("=>" @operator) (#set! conceal "󰧂 "))
(("===" @operator) (#set! conceal ""))
(("??" @operator) (#set! conceal ""))
(("!==" @operator) (#set! conceal "󰦎"))
(("&&" @operator) (#set! conceal "∧"))
(("||" @operator) (#set! conceal "∨"))
((">=" @operator) (#set! conceal "≥"))
(("<=" @operator) (#set! conceal "≤"))
; (("!!" @operator) (#set! conceal "¬"))
(("new" @operator) (#set! conceal "󰆧 "))

(("?" @keyword.conditional.ternary) (#set! conceal "¿"))

; (("null" @builtin) (#set! conceal "󰟢"))
(("try" @keyword.exception) (#set! conceal "󰿎 "))
(("catch" @keyword.exception) (#set! conceal "☇"))
(("finally" @keyword.exception) (#set! conceal "󰑆 "))
(("throw" @keyword.exception) (#set! conceal "󰚽 "))

(("switch" @conditional) (#set! conceal "󰀁"))
(("case" @conditional) (#set! conceal "󰜴"))

(("while" @keyword.repeat) (#set! conceal "󰛤 "))
(("for" @keyword.repeat) (#set! conceal "󰛥 "))

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

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "map")
        (#set! conceal "")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "filter")
        (#set! conceal " ")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "reduce")
        (#set! conceal "󰦸")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "find")
        (#set! conceal " ")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "includes")
        (#set! conceal "󰤌 ")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "forEach")
        (#set! conceal "󰛥 ")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "some")
        (#set! conceal "∃")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "every")
        (#set! conceal "∀")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "join")
        (#set! conceal "󰡌 ")
    )
)

(call_expression
  function:
    (member_expression
      property: (property_identifier) @function.method.call
        (#eq? @function.method.call "split")
        (#set! conceal "󰡎 ")
    )
)

(member_expression
  property: (property_identifier) @variable.member
    (#eq? @variable.member "length")
    (#set! conceal " ")
)

(member_expression
  property: (property_identifier) @variable.member
    (#eq? @variable.member "current")
    (#set! conceal "󰧆")
)
