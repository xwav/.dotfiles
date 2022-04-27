#set date on top bar
~/xsetroot.sh & 

#xrdb -merge ~/.Xresources

feh --bg-scale --randomize  ~/.config/wallpapers/* &
xcompmgr -c &
conky &
xbacklight -set 0.65 &

#exec dwm
while true; do
	/usr/local/bin/dwm 2> /dev/null
done
