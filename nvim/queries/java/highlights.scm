; extends

(("class" @keyword.java) (#set! conceal "󰆟 "))
(("import" @include.java) (#set! conceal "󰞒 "))

(("private" @type.qualifier) (#set! conceal ""))
(("public" @type.qualifier) (#set! conceal "󰈈 "))
; (("static" @type.qualifier) (#set! conceal "󰮄 "))

; (("void" @type.builtin) (#set! conceal "󰟢 "))

(("new" @keyword.operator.java) (#set! conceal "󰆧 "))

; (("===" @operator) (#set! conceal ""))
; (("??" @operator) (#set! conceal ""))
(("!=" @keyword.operator) (#set! conceal "󰦎"))
(("&&" @keyword.operator) (#set! conceal "∧"))
(("||" @keyword.operator) (#set! conceal "∨"))
((">=" @keyword.operator) (#set! conceal "≥"))
(("<=" @keyword.operator) (#set! conceal "≤"))

(("return" @keyword.return.tsx) (#set! conceal ""))

(("if" @keyword.conditional.tsx) (#set! conceal ""))
(("else" @keyword.conditional.tsx) (#set! conceal ""))

(("try" @keyword.exception) (#set! conceal "󰿎 "))
(("catch" @keyword.exception) (#set! conceal "󱐋"))
(("finally" @keyword.exception) (#set! conceal "󰑆 "))
(("throw" @keyword.exception) (#set! conceal "󰚽 "))

(("throws" @exception.java) (#set! conceal " "))

(("switch" @conditional) (#set! conceal "󰀁"))
(("case" @conditional) (#set! conceal "󰜴"))

(("while" @keyword.repeat) (#set! conceal "󰛤 "))
(("for" @keyword.repeat) (#set! conceal "󰛥 "))

; (("void" @type.builtin.java) (#set! conceal "󰟢 "))

; (("null" @constant.builtin.java) (#set! conceal "󰟢 "))

; (method_invocation
;   name (identifier) @function.method.call
;     (#eq? @function.method.call "length")
;     (#set! conceal " ")
; )

(method_invocation
  name: (identifier) @function.method.call
  (#eq? @function.method.call "length")
  (#set! conceal " ")
)

