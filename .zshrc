export PATH="$HOME/.local/bin:/opt/homebrew/bin:/Applications/cmux.app/Contents/Resources/bin:$PATH"

# Cached compinit — only rebuilds once per day
autoload -U compinit
if [[ -f ~/.zcompdump && $(date +'%j') == $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]]; then
  compinit -C
else
  compinit
fi
# case-insensitive, partial-word, and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]= r:|=' 'l:|=* r:|=*'

function parse_git_branch() {
    git branch 2> /dev/null | sed -n -e 's/^\* \(.*\)/[\1]/p'
}

setopt PROMPT_SUBST
PROMPT='%F{197}%~ %F{39}$(parse_git_branch)%f '

# NVM — lazy loaded for faster shell startup
export NVM_DIR="$HOME/.nvm"
lazy_load_nvm() {
  unset -f node npm npx nvm
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}
for cmd in node npm npx nvm; do
  eval "${cmd}() { lazy_load_nvm; ${cmd} \"\$@\"; }"
done

# Quick aliases for AI tools
alias cc='claude'
alias cx='codex'

# New cmux workspaces start at home; splits within a workspace keep their directory
if [[ -n "${CMUX_TAB_ID:-}" ]]; then
    _cmux_seen="/tmp/cmux-seen-workspaces"
    if ! grep -qF "$CMUX_TAB_ID" "$_cmux_seen" 2>/dev/null; then
        echo "$CMUX_TAB_ID" >> "$_cmux_seen"
        cd "$HOME"
    fi
    unset _cmux_seen
fi

# pnpm
export PNPM_HOME="/Users/abduljamac/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
