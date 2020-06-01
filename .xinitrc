while true; do
  xsetroot -name " $(date | sed 's/.\{10\}$//') "
  sleep 1m
done &

xsetroot -cursor_name arrow

feh --bg-scale ~/Pictures/darkmountains.jpg &
exec dwm
