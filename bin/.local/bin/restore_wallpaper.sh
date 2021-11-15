#!/usr/bin/env bash

wall_dir=~/wallpapers
def_wall=~/.local/share/bg.jpg


set_def_wall() {
	wall="$(find "$wall_dir" -type f -name "*.jpg" -o -name "*.png" | shuf -n1)"

	if [ -z $wall ]; then
		exit
	fi
	
	convert "$wall" "$def_wall"
}

check_wall_dir() {
	if [ ! -d "$wall_dir" ]; then
		exit
	fi

	set_def_wall
}

check_def_wall() {
	if [ ! -f "$def_wall" ]; then
		check_wall_dir
	fi
}

if [ -z "$1" ]; then
	check_def_wall
else
	convert "$1" "$def_wall"
fi

xwallpaper --output all --zoom "$def_wall"
