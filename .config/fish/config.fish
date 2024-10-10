if status is-interactive
	# ctrl-delete
	bind \e\[3\;5~ kill-word
	# ctrl-backspace
	bind \b backward-kill-word
end

# start rbenv
status --is-interactive; and rbenv init - fish | source
