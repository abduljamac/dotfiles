# Dotfiles

Personal configuration files for macOS.

## Files

### `.gitconfig`

Git configuration with user identity, command aliases, and SSH enforcement.

| Alias | Command |
|-------|---------|
| `git a` | `git add` |
| `git aa` | `git add .` |
| `git cm "msg"` | `git commit -m "msg"` |
| `git ca` | `git commit --amend --no-edit` |
| `git p` | `git push` |
| `git pf` | `git push -f` |
| `git s` | `git status` |

Also automatically rewrites GitHub HTTPS URLs to SSH so you never have to think about it.

### `.gitignore_global`

Global gitignore applied to all repositories. Ignores:

- `.DS_Store` — macOS Finder metadata
- `.vscode/` — VS Code workspace settings
- `node_modules/` — npm dependencies
- `.env` — environment variables / secrets
- `*.log` — log files
- `.claude/` — Claude Code local settings

### `.zshrc`

Shell configuration including:

- **Homebrew** path setup
- **Optimized compinit** — cached tab completion that only rebuilds once per day
- **Case-insensitive completion** — tab complete regardless of casing
- **Custom prompt** — shows current directory and git branch
- **NVM lazy loading** — Node version manager loads on first use instead of every shell startup
- **AI tool aliases** — `cc` for Claude Code, `cx` for Codex
- **Startup prompt** — interactive menu to launch Claude, Codex, or a regular terminal

## Setup on a New Laptop

### 1. Install prerequisites

```bash
# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install Git (comes with Xcode CLI tools)
xcode-select --install

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

### 2. Set up SSH key for GitHub

```bash
ssh-keygen -t ed25519 -C "abduljama001@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub
```

Copy the output and add it at https://github.com/settings/keys.

### 3. Clone and install dotfiles

```bash
git clone git@github.com:abduljamac/dotfiles.git ~/dotfiles
```

### 4. Symlink the files

```bash
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/.gitignore_global ~/.gitignore_global
ln -sf ~/dotfiles/.zshrc ~/.zshrc
```

### 5. Restart your terminal

```bash
source ~/.zshrc
```
