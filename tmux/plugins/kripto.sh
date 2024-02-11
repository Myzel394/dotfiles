#!/bin/bash

show_kripto() {
    local index=$1
    local icon="$(get_tmux_option "@catppuccin_kripto_icon" "ɱ")"
    local color="$(get_tmux_option "@catppuccin_kripto_color" "#fab387")"
    local text="$(get_tmux_option "@catppuccin_kripto_text" "#{kripto}")"

    local module=$( build_status_module "$index" "$icon" "$color" "$text" )

    echo "$module"
}
