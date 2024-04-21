; extends

(("const" @storageclass.rust) (#set! conceal "󱥦 "))

(("fn" @keyword.function) (#set! conceal "󰊕"))
(("pub" @keyword.rust) (#set! conceal "󰈈 "))

(("return" @keyword.rust) (#set! conceal ""))
; (("yield" @keyword.rust) (#set! conceal "󱞽 "))

(("async" @keyword.coroutine) (#set! conceal ""))
(("await" @keyword.coroutine) (#set! conceal ""))

(("let" @keyword.rust) (#set! conceal "󰁃"))
; (("mut" @type.qualifier.rust) (#set! conceal "󰏫 "))

(("use" @include.rust) (#set! conceal "󰞒 "))

(("while" @repeat.rust) (#set! conceal "󰛤 "))
(("for" @repeat.rust) (#set! conceal "󰛥 "))
(("break" @repeat.rust) (#set! conceal "󰂭 "))
(("continue" @repeat.rust) (#set! conceal ""))

(("if" @conditional.rust) (#set! conceal ""))
(("else" @conditional.rust) (#set! conceal ""))
(("match" @conditional.rust) (#set! conceal "󱞩 "))

(("!=" @operator.rust) (#set! conceal "󰦎"))
(("&&" @operator.rust) (#set! conceal "∧"))
(("||" @operator.rust) (#set! conceal "∨"))
((">=" @operator.rust) (#set! conceal "≥"))
(("<=" @operator.rust) (#set! conceal "≤"))

; Structs
(("struct" @keyword.rust) (#set! conceal "󰆟 "))
(("impl" @keyword.rust) (#set! conceal "󰮄 "))
; (("self" @variable.builtin.rust) (#set! conceal "󰜮 "))

; (("unwrap" @variable.rust) (#set! conceal "󰧆"))

; (method_invocation
;   name: (identifier) @function.method.call
;   (#eq? @function.method.call "length")
;   (#set! conceal " ")
; )


; (mutable_specifier "mut"  @keyword.modifier) (#set conceal "⦖")

; Matches `Ok()` -> `󰸞()`
(call_expression
  function: (identifier) @function.call
  (#eq? @function.call "Ok")
  (#set! conceal "󰸞 ")
)
(call_expression
  function: (identifier) @function.call
  (#eq? @function.call "Err")
  (#set! conceal " ")
)

(let_declaration
    (mutable_specifier) @keyword.modifier
    (#set! conceal " ")
)

; Matches `xxx::new()` -> `󰆟 ()` 
(call_expression
  function:
    (scoped_identifier
      (identifier) @function.call .)
  (#eq? @function.call "new")
  (#set! conceal "󰆟 ")
)

((field_expression
    field: (field_identifier) @function.call)
    (#eq? @function.call "unwrap")
    (#set! conceal "󰧆")
)
((field_expression
    field: (field_identifier) @function.call)
    (#eq? @function.call "clone")
    (#set! conceal " ")
)
((field_expression
    field: (field_identifier) @function.call)
    (#eq? @function.call "collect")
    (#set! conceal "󱥪 ")
)

((field_expression
    field: (field_identifier) @function.call)
    (#eq? @function.call "len")
    (#set! conceal " ")
)

; Functions
((field_expression
    field: (field_identifier) @function.call)
    (#eq? @function.call "map")
    (#set! conceal "")
)
