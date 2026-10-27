#
# ~/.bashrc
#

[[ $- == *i* ]] && source -- ~/.local/share/blesh/ble.sh --attach=none --rcfile ~/.blerc

export KITTY_WINDOW_ID=$(printf '\033[11t')

set -o vi

PS1='[\u \[\e[35m\]=^·ω·^=\[\e[0m\]] \W \$ '

for f in ~/.config/bash/{exports,vars,aliases,util,third-party}.sh; do
    [[ -f "$f" ]] && source "$f"
done

[[ ! ${BLE_VERSION-} ]] || ble-attach
