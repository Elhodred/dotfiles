#!/usr/bin/env bash

uptime=$(uptime -p | sed -e 's/up //g')

# Options
shutdown=""
reboot=""
lock=""
suspend=""
logout=""

# Confirmation
confirm_exit() {
	dmenu\
		-i\
		-l 0\
		-p "Are You Sure? : "
}

# Variable passed to dmenu
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | dmenu -i -l 0 -p "Uptime: $uptime")"
case $chosen in
    $shutdown)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl poweroff
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        fi
        ;;
    $reboot)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			systemctl reboot
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        fi
        ;;
    $lock)
		slock
        ;;
    $suspend)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			playerctl pause
			amixer set Master mute
			systemctl suspend
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        fi
        ;;
    $logout)
		ans=$(confirm_exit &)
		if [[ $ans == "yes" || $ans == "YES" || $ans == "y" || $ans == "Y" ]]; then
			session=`loginctl session-status | head -n 1 | awk '{print
			 $1}'`
			loginctl terminate-session $session
		elif [[ $ans == "no" || $ans == "NO" || $ans == "n" || $ans == "N" ]]; then
			exit 0
        fi
        ;;
esac
