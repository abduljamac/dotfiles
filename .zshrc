export PATH=/opt/homebrew/bin:$PATH

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

# Terminal startup prompt — choose your session type
if [[ -o interactive && -z "$CLAUDE_STARTUP_DONE" ]]; then
  export CLAUDE_STARTUP_DONE=1
  echo ""
  echo "What would you like to open?"
  echo "  [1] Claude Code CLI"
  echo "  [2] Codex CLI"
  echo "  [3] Regular Terminal"
  echo ""
  read -k 1 "choice?> "
  echo ""
  case "$choice" in
    1) claude ;;
    2) codex ;;
    3) ;; # just continue to regular shell
    *) echo "Continuing with regular terminal..." ;;
  esac
fi
