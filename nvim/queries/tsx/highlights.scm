; extends

; (("/>" @tag.delimiter) (#set! conceal "󰛢"))

(jsx_attribute
  (property_identifier) @tag.attribute
  (#eq? @tag.attribute "className")
  (#set! conceal "类")
)

; Meaning: "big", "huge", "large" in Chinese
(jsx_attribute
  (property_identifier) @tag.attribute
  (#eq? @tag.attribute "size")
  (#set! conceal "大")
)

(jsx_attribute
  (property_identifier) @tag.attribute
  (#eq? @tag.attribute "id")
  (#set! conceal "Я")
)

(jsx_attribute
  (property_identifier) @tag.attribute
  (#eq? @tag.attribute "style")
  (#set! conceal "󰌜 ")
)

(jsx_attribute
  (property_identifier) @tag.attribute
  (#eq? @tag.attribute "key")
  (#set! conceal "󰌋 ")
)

; Match if attribute and value are equal
; example: <div open={open} />
(jsx_attribute
  (property_identifier) @tag.attribute @key
  (jsx_expression
    (identifier) @variable @value
    (#eq? @key @value)
    (#set! conceal "")
  )
)

(jsx_opening_element
  name: (identifier) @tag.builtin
  (#eq? @tag.builtin "div")
  (#set! conceal "")
)
(jsx_closing_element
  name: (identifier) @tag.builtin
  (#eq? @tag.builtin "div")
  (#set! conceal "")
)
