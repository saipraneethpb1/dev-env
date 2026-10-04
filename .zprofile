export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"

if [[ -z "$WAYLAND_DISPLAY" ]] && [[ "$(tty)" == "/dev/tty1" ]]; then
    exec uwsm start hyprland.desktop
fi
