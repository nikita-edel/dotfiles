alias nv='nvim'
alias n='nvim'

alias grep='grep --color=auto'

alias ls='eza --color=always --git --icons=always --no-time --no-user --no-permissions'
alias lsa='ls -a --color=auto "$@"'

# for typos
alias cd..='cd ..'
alias lsd='ls'
#

alias cd='z'

alias rebash="source ~/.bashrc"
alias s0='shutdown 0'
alias r0='reboot'
alias c='clear'
alias e='exit'

alias gpoh='git push origin HEAD'

alias ytm='youtube-music-desktop-app'

alias boot-win='systemctl reboot --boot-loader-entry=auto-windows'
alias boot-bios='systemctl reboot --firmware-setup'

pdf() {
    zathura "$@" & disown
}

chrome() {
    google-chrome-stable "$@"
}

mkcd() {
    mkdir "$@"
    cd "$@"
}
