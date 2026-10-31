eval "$(starship init bash)"

if [[ $TERM_PROGRAM == ghostty && -r $GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash ]]; then
    source -- "$GHOSTTY_RESOURCES_DIR/shell-integration/bash/ghostty.bash"
fi

eval "$(zoxide init bash)"
