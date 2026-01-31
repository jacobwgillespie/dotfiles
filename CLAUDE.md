# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for configuring macOS/Linux with ZSH and Homebrew. It uses a symlink-based approach where files in `symlinks/` ending with `.symlink` are linked to the home directory.

## Commands

### Initial Setup

```bash
./setup                    # Full install: Homebrew, packages, symlinks, macOS config
```

### Package Management

```bash
brew bundle                # Install all packages from Brewfile
brew bundle cleanup        # Remove packages not in Brewfile
```

### Symlinks Only

```bash
./scripts/install-symlinks # Re-run symlink installation
```

### macOS Configuration

```bash
./scripts/configure-macos  # Apply macOS defaults (Dock, keyboard, etc.)
```

### Shell Profiling

```bash
ZSH_PROF=1 zsh             # Profile shell startup time
```

## Architecture

### Directory Structure

- **`bin/`** - Executable scripts added to `$PATH`
- **`config/*.zsh`** - ZSH config modules, all sourced automatically by `.zshrc`
- **`functions/`** - ZSH functions and completion definitions
- **`symlinks/`** - Files with `.symlink` suffix get linked to `$HOME` (suffix removed)
- **`plugins/`** - ZSH plugins (notably `zsh-defer` for lazy loading)
- **`scripts/`** - Setup and installation scripts

### Symlink Convention

Files ending in `.symlink` anywhere under `symlinks/` are symlinked to the equivalent path in `$HOME`:

- `symlinks/.zshrc.symlink` → `~/.zshrc`
- `symlinks/.config/mise.symlink/` → `~/.config/mise/`

### Shell Initialization Flow

1. `.zshrc` sets up Homebrew environment
2. Loads `zsh-defer` plugin for deferred loading
3. Sources all files in `config/*.zsh`
4. Sources `~/.localrc` if it exists (machine-specific overrides)
5. Defers slow plugins (autosuggestions, syntax highlighting) for faster startup

### Key Configuration Files

- **`Brewfile`** - All packages, casks, and VS Code extensions
- **`symlinks/.gitconfig.symlink`** - Git config with SSH signing via 1Password
- **`config/editor.zsh`** - Sets Cursor as default editor
- **`config/node.zsh`** - Package manager detection (bun/pnpm/yarn)
- **`config/mise.zsh`** - Mise version manager (Go, Node, Terraform)

### Adding New Configuration

1. **New ZSH config**: Add `config/foo.zsh` - automatically sourced
2. **New dotfile**: Add to `symlinks/` with `.symlink` suffix, run `./scripts/install-symlinks`
3. **New executable**: Add to `bin/` - automatically in `$PATH`
4. **New ZSH function**: Add to `functions/`
