# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
if command -v flatpak 2>&1 >/dev/null
then # import flatpak binaries to path
    PATH="/var/lib/flatpak/exports/bin/:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

#alias spotify='flatpak run com.spotify.Client'
#alias discord='flatpak run com.discordapp.Discord'

alias c='cd ..'
alias l='ls -latr | more'

# check if im not in tmux
#if [ -z "${TMUX}" ]; then
#	cal
#fi

unset rc
setxkbmap jptr
