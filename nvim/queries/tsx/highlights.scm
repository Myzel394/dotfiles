; extends

; (("/>" @tag.delimiter) (#set! conceal "󰛢"))

((identifier) @function.call
    (#eq? @function.call "useEffect")
    (#set! conceal "󰛢")
)

((identifier) @function.call
    (#eq? @function.call "useState")
    (#set! conceal "")
)

((identifier) @function.call
    (#eq? @function.call "useRef")
    (#set! conceal "")
)

