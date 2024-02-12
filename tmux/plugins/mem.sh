show_mem() {
    local index=$1

    local icon="$(get_tmux_option "@catppuccin_test_icon" "")"
    local color="$(get_tmux_option "@catppuccin_test_color" "$thm_blue")"
    var=$(free --giga | awk '/^Mem:/ {print $3 "/" $7 "/" $2 "GB"}')
    local text="$(get_tmux_option "@catppuccin_test_text" "#(date +%s)")"

    local module=$( build_status_module "$index" "$icon" "$color" "$text" )

    echo "$module"
}
