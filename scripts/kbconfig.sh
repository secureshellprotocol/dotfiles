#!/bin/bash
#	Simple script to permaswap CAPS_LOCK and ESC on Linux
#	written by james

echo -ne "running as $USER\nhome is $HOME\n continue?(y/n) "
#if read fails it means we arent in bash. oops!
if ! read -p "" -n 1 -r; then
	echo "read failed! use bash."
	exit 1
fi
echo #newline lol!

if [[ ! $REPLY =~ ^[Yy]$ ]]; then
	exit 1
fi

if [ -f /usr/share/X11/xkb/symbols/jptr ]; then
	echo -ne "setup was already provisioned.\n overwrite?(y/n) "
	
	if ! read -p "" -n 1 -r; then
		echo "read failed! use bash."
		exit 1
	fi
	echo #newline lol!

	if [[ $REPLY =~ ^[Yy]$ ]]; then
		echo -n "overwriting... "
		sudo rm /usr/share/X11/xkb/symbols/jptr
	else
		echo -n "not overwriting... exiting successfully"
		exit 0
	fi
fi

#BEGIN THE SUMMONING RITUAL
if [ ! -d $HOME/.config/jptr/keyboard ]; then
	mkdir -p $HOME/.config/jptr/keyboard
fi

WORKDIR=$HOME/.config/jptr/keyboard
if [ ! -d "/usr/share/X11/xkb/symbols/" ]; then
	echo "/usr/share/X11/xkb/symbols/ does not exist.
		unfortunately, your setup is not supported."
	exit 1
fi

cat << EOF > $WORKDIR/config
default partial alphanumeric_keys
xkb_symbols "uc" {
    name[Group1]="uc";
    include "us(basic)"
    key <ESC> { [Caps_Lock] };
    key <CAPS> { [Escape] };
};
EOF

#lazy provision
sudo ln -s $WORKDIR/config /usr/share/X11/xkb/symbols/jptr
if [ -f $HOME/.bashrc ]; then
	touch $HOME/.bashrc
fi

if [[ -z $(grep "setxkbmap jptr" "$HOME"/.bashrc) ]]; then
	echo setxkbmap jptr >> $HOME/.bashrc
else
	echo -n "bashrc already configured... "
fi
setxkbmap jptr

echo done. no error occured.
exit 0
