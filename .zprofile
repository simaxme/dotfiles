if [ -n "$XDG_VTNR" ] && [ "$XDG_VTNR" -eq 1 ] && [ -z "$WAYLAND_DISPLAY" ]; then
  export QT_QPA_PLATFORMTHEME="gtk3"

  exec sway
fi

