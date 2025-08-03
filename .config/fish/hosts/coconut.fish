# start fnm
fnm env --use-on-cd --shell fish | source

# start rbenv
status --is-interactive; and rbenv init - fish | source

# start pyenv
pyenv init - fish | source
