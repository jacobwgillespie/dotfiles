# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a dotfiles repository for configuring macOS or Linux environments with ZSH and Homebrew. It provides a complete development environment setup including shell configuration, developer tools, and applications.

## Key Commands

### Repository Management

- `./setup` - Main setup script that installs Homebrew, software packages, and configures the system
- `dot` - ZSH function to quickly cd to the dotfiles directory ($HOME/.dotfiles)
- `./scripts/install-symlinks` - Install or update symlinked configuration files
- `./scripts/configure-macos` - Apply macOS-specific system settings (macOS only)

### Package Management

- `brew bundle` - Install/update all software defined in Brewfile
- `brew bundle cleanup` - Remove software not listed in Brewfile

### Git Workflows

- `g` - Alias for git
- `gp` - Push current branch to origin
- `gpf` - Push current branch to origin with force-with-lease
- `gs` - Git status with short format
- `glog` - Pretty formatted git log
- `grb` - Git rebase preserving author dates
- `s` - Git sync command (alias for `git sync`)
- `pr` - GitHub PR helper (without args: list PRs, with number: checkout PR, else pass to gh pr)
- `git-undo` - Undo last commit (in bin/)
- `git-track` - Track remote branch (in bin/)
- `git-tidy` - Clean up local branches (in bin/)
- `git-mup` - Merge upstream changes (in bin/)
- `jj` - Use Jujutsu (jj) version control instead of git in this repository

### Editor & Development

- `e <file>` - Opens files in Cursor (in bin/)
- `b` - List, checkout, or create git branches (in bin/)
- `+x` - Make file executable (in bin/)

### System Utilities

- `clr` - Clear terminal screen with proper support for iTerm2
- `flush` - Flush DNS cache
- `cleanup` - Recursively delete .DS_Store files
- `loadenv` - Load environment variables from .env file
- `extract <file>` - Extract various archive formats (tar, zip, dmg, etc.)
- `lscleanup` - Remove duplicates in "Open With" menu (macOS)
- `show`/`hide` - Show/hide hidden files in Finder (macOS)
- `fix-monitor` - Fix monitor issues (in bin/)
- `ips` - Show IP addresses (in bin/)

## Architecture

### Directory Structure

```
.dotfiles/
├── setup                  # Main installation script
├── Brewfile               # Software packages to install via Homebrew
├── bin/                   # Executable scripts added to PATH
├── config/                # ZSH configuration files (*.zsh)
├── functions/             # ZSH functions and completions
├── scripts/               # Helper scripts for setup
└── symlinks/              # Files to symlink to home directory (*.symlink)
```

### Key Components

1. **Setup System**:

   - `setup` script orchestrates the entire installation
   - Installs Homebrew if needed
   - Runs `brew bundle` to install software
   - Configures macOS settings
   - Creates symlinks for configuration files

2. **ZSH Configuration**:

   - Entry point: `symlinks/.zshrc.symlink`
   - Loads all `config/*.zsh` files automatically
   - Sets up completion, plugins, and keybindings
   - Configures PATH to include `./bin`, `~/bin`, and `$DOTFILES/bin`

3. **Plugin System**:

   - Uses zsh-defer for performance optimization
   - Includes zsh-autosuggestions, zsh-syntax-highlighting, and zsh-history-substring-search
   - Manages completions for various tools

4. **Tool Integrations**:
   - Language environments: Node.js, Go, Ruby, Rust, Java, Python (uv)
   - Cloud platforms: AWS, Google Cloud
   - Container tools: Docker, Kubernetes
   - Version managers: mise
   - Development tools: GitHub CLI (gh), Terraform, MySQL, Jujutsu (jj), Zoxide
   - Security: 1Password CLI integration

### Environment Variables

- `$DOTFILES` - Points to the dotfiles directory ($HOME/.dotfiles)
- `$XDG_CONFIG_HOME` - Standard config directory (`~/.config`)
- `$PROJECTS` - Default directory for code projects (`~/Code`)
- `$EDITOR` - System editor (defaults to Cursor on macOS, VS Code otherwise)
- `$HOMEBREW_PREFIX` - Path to Homebrew installation

## Working with Files

### Creating New Configuration

1. Add ZSH configuration: Create a file in `config/` with `.zsh` extension
2. Add executable: Create a file in `bin/` and make it executable
3. Add function: Create a file in `functions/` (will be autoloaded)
4. Add symlink: Create a file in `symlinks/` with `.symlink` extension

### Testing Changes

- Source changes: `source ~/.zshrc` or start a new shell
- Test specific config: `source config/your-config.zsh`

### Making Changes

When editing this repository:

1. Test changes in a new shell before committing
2. Follow existing patterns for naming and organization

### Special Files

- `.gitconfig.symlink.example` - Template for git configuration (setup creates actual .gitconfig.symlink)
- `.localrc` - Local machine-specific settings (not tracked in git, sourced if exists)
- `CLAUDE.md` - This file

## Important Notes

- The setup script enables Touch ID for sudo on macOS
- ZSH profiling can be enabled by setting `ZSH_PROF` environment variable
- Editor defaults to Cursor instead of VS Code (see functions/e)
- Git sync (`s` alias) requires git-sync command to be installed separately
- All config/\*.zsh files are automatically sourced in new shells
