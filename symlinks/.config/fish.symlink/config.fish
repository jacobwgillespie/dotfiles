# Homebrew environment
if test -x /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
else if test -x /home/linuxbrew/.linuxbrew/bin/brew
    eval (/home/linuxbrew/.linuxbrew/bin/brew shellenv)
else if test -x /usr/local/bin/brew
    eval (/usr/local/bin/brew shellenv)
end

# Base environment
set -gx DOTFILES "$HOME/.dotfiles"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx PROJECTS "$HOME/Code"
set -gx GOPATH "$HOME/.go"
set -gx CLICOLOR true
set -gx LSCOLORS Gxfxcxdxbxegedabagacab
set -gx LS_COLORS 'no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:ow=0;41:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:*.patch=00;34:*.o=00;32:*.so=01;35:*.ko=01;31:*.la=00;33'
set -gx NPM_CONFIG_FUND false
set -gx DOCKER_SCAN_SUGGEST false
set -gx EDITOR 'cursor --wait'
set -gx STARSHIP_CONFIG "$DOTFILES/config/starship/config.toml"
set -gx CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS 1
set -gx OPENCODE_EXPERIMENTAL_MARKDOWN 1
set -gx OPENCODE_ENABLE_EXA true
set -g fish_color_command green
set -g fish_greeting ''

# PATH
set -gx PATH ./bin "$HOME/bin" "$DOTFILES/bin" $PATH
fish_add_path -m "$HOME/.local/bin" "$HOME/.go/bin" "$HOME/.cargo/bin" "$HOME/Library/pnpm"
if test -d /opt/homebrew/opt/mysql-client@8.4/bin
    fish_add_path --prepend /opt/homebrew/opt/mysql-client@8.4/bin
end

if status is-interactive
    # 1Password SSH agent
    if test -e "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    end

    # Tool init
    type -q mise; and mise activate fish | source
    type -q zoxide; and zoxide init fish | source
    test -f "$HOME/.orbstack/shell/init2.fish"; and source "$HOME/.orbstack/shell/init2.fish"

    # Prompt
    type -q starship; and starship init fish | source

    # History search on up/down arrows.
    bind up history-search-backward
    bind down history-search-forward

    # Aliases
    if test "$TERM_PROGRAM" = 'iTerm.app'
        alias clr "printf '\e]1337;ClearScrollback\a'"
    else
        alias clr 'tput reset'
    end

    alias flush 'sudo killall -HUP mDNSResponder'
    alias lscleanup '/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user; and killall Finder'
    type -q hd; or alias hd 'hexdump -C'
    alias cleanup "find . -type f -name '*.DS_Store' -ls -delete"
    alias show 'defaults write com.apple.finder AppleShowAllFiles -bool true; and killall Finder'
    alias hide 'defaults write com.apple.finder AppleShowAllFiles -bool false; and killall Finder'
    alias tada 'open -g raycast://confetti'

    alias cc 'claude --dangerously-skip-permissions'

    alias g git
    alias glog "git log --graph --pretty=format:'%Cred%h%Creset %an: %s%Creset%C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
    alias gp 'git push origin HEAD'
    alias gpf 'git push origin HEAD --force-with-lease'
    alias gs 'git status -sb'
    alias grb 'git rebase --committer-date-is-author-date'
    alias s 'git sync'

    type -q terraform; and alias t terraform

    if type -q eza
        alias ls 'eza -F auto'
        alias l 'eza -la'
        alias ll 'eza -l'
        alias tree 'eza -TF auto'
    else
        alias ls 'ls -F'
        alias l 'ls -lAh'
        alias ll 'ls -l'
    end

    if type -q bat
        alias cat bat
        set -gx BAT_STYLE plain
        set -gx BAT_THEME ansi
    end

    # Source host-specific local overrides
    test -f "$HOME/.local.fish"; and source "$HOME/.local.fish"
end
