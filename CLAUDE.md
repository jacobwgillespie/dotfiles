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

### Common Development Workflows

- `g` - Alias for git
- `gp` - Push current branch to origin
- `gs` - Git status with short format
- `s` - Git sync command
- `e <file>` - Function to open files in the editor
- `pr` - GitHub PR helper function

### System Utilities

- `clr` - Clear terminal screen with proper support for iTerm2
- `flush` - Flush DNS cache
- `cleanup` - Recursively delete .DS_Store files
- `loadenv` - Load environment variables from .env file
- `extract <file>` - Extract various archive formats

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
   - Language environments: Node.js, Go, Ruby, Rust, Java, Python
   - Cloud platforms: AWS, Google Cloud
   - Container tools: Docker, Kubernetes, Colima
   - Version managers: asdf, n (Node.js)
   - Development tools: GitHub CLI, Terraform, MySQL

### Environment Variables

- `$DOTFILES` - Points to the dotfiles directory
- `$XDG_CONFIG_HOME` - Standard config directory (`~/.config`)
- `$PROJECTS` - Default directory for code projects (`~/Code`)
- `$EDITOR` - System editor (defaults to 'code --wait')

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
- `.localrc` - Local machine-specific settings (not tracked in git)
- `CLAUDE.md` - This file
