if [ -z "$DISPLAY" ] && [ -z "$WAYLAND_DISPLAY" ]; then
    CURRENT_TTY="$(tty)"

    if [[ "$CURRENT_TTY" == "/dev/tty1" ]]; then
        exec niri --session
    elif [[ "$CURRENT_TTY" == "/dev/tty2" ]]; then
        # exec start-hyprland
        :
    fi
fi
