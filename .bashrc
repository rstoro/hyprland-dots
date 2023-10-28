[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'

eval "$(starship init bash)"
cat ~/.cache/wal/sequences
echo ""
pfetch
wal --preview
