#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias vim='nvim'

eval "$(starship init bash)"
cat ~/.cache/wal/sequences
echo ""
pfetch
