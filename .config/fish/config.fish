if status is-interactive
	# ctrl-delete
	bind \e\[3\;5~ kill-word
	# ctrl-backspace
	bind \b backward-kill-word
end

# start rbenv
status --is-interactive; and rbenv init - fish | source

# zoxide
zoxide init fish | source
alias cd="z"

# eza
alias ls="eza --long --icons --git --all --bytes --no-permissions --no-user --mounts --grid --group-directories-first"

# sesh
alias s="sesh connect (sesh list | fzf)"