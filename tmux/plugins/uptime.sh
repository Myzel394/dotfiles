#!/bin/bash

export get_uptime() {
    echo "$(date +%s)"
}

show_uptime() {
    # local full_uptime_in_seconds="$(cat /proc/uptime | cut --delimiter="." --fields=1)"
    # local uptime_in_seconds="$((full_uptime_in_seconds % 60))"
    # local uptime_in_minutes="$((raw_uptime_in_seconds / 60 % 60))"
    # local uptime_in_hours="$((raw_uptime_in_seconds / 60 % 24))"
    # local uptime_in_days="$((raw_uptime_in_seconds / 24))"

    local formatted_string="$(date +%s)"

    # if [[ "$uptime_in_days" -gt 0 ]]; then
    #     formatted_string="$uptime_in_days d, $uptime_in_hours h, $uptime_in_minutes m"
    # elif [[ "$uptime_in_hours" -gt 0 ]]; then
    #     formatted_string="$uptime_in_hours h, $uptime_in_minutes m"
    # elif [[ "$uptime_in_minutes" -gt 0 ]]; then
    #     formatted_string="$uptime_in_minutes m, $uptime_in_seconds s"
    # else
    #     formatted_string="$uptime_in_seconds s"
    # fi

    local index=$1
    local icon="$(get_tmux_option "@catppuccin_uptime_icon" " ")"
    local color="$(get_tmux_option "@catppuccin_uptime_color" "#EA999C")"
    local text="$(get_tmux_option "@catppuccin_uptime_text" "#(get_uptime)")"

    local module=$( build_status_module "$index" "$icon" "$color" "$text" )

    echo "$module"
}
