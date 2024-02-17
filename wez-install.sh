if [ -f "/proc/sys/fs/binfmt_misc/WSLInterop" ]; then
	winhome=$(wslpath "$(wslvar USERPROFILE)")
	cp .wezterm.lua $winhome
	echo "Copied .wezterm.lua to $winhome"
else
	cp .wezterm.lua ~/.wezterm.lua
fi
