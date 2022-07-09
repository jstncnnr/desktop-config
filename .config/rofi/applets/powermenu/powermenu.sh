#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
## Github  : @adi1090x
## Twitter : @adi1090x

theme="drop_square"
dir="$HOME/.config/rofi/applets/styles"


uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $dir/$theme"

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Message
msg() {
	rofi -theme "$dir/message.rasi" -e "Available Options  -  yes / y / no / n"
}

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "Uptime: $uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
			systemctl poweroff
        ;;
    $reboot)
			systemctl reboot
        ;;
    $lock)
		if [[ -f /usr/bin/i3lock ]]; then
			i3lock -e -i "$HOME/.config/wallpapers/0QvF0SR.png"
		fi
        ;;
    $suspend)
			playerctl --all-players stop
			pactl set-sink-mute 0 1
			systemctl suspend
        ;;
    $logout)
			if [[ "$DESKTOP_SESSION" == "bspwm" ]]; then
				bspc quit
			fi
        ;;
esac
