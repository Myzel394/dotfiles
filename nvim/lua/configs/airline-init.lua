-- Hacky way to change the colors of the airline theme
-- but couldn't find a better way to do it
vim.cmd [[
    let g:airline_powerline_fonts = 1
    let g:airline_theme = "murmur"

    function! g:AirlineThemePatch(palette)
        if g:airline_theme == 'murmur'
            let s:counter = 0

            for colors in values(a:palette.normal)
                if s:counter == 5
                    let colors[1] = "#333333"
                endif

                let s:counter += 1
            endfor
        endif
    endfunction
    let g:airline_theme_patch_func = 'AirlineThemePatch'
]]

