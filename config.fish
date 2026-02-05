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
set -gx CLICOLOR true
set -gx LSCOLORS Gxfxcxdxbxegedabagacab
set -gx LS_COLORS 'no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:ow=0;41:*.cmd=00;32:*.exe=01;32:*.com=01;32:*.bat=01;32:*.btm=01;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.lzma=00;31:*.zip=00;31:*.zoo=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.tb2=00;31:*.tz2=00;31:*.tbz2=00;31:*.avi=01;35:*.bmp=01;35:*.fli=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mng=01;35:*.mov=01;35:*.mpg=01;35:*.pcx=01;35:*.pbm=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.tga=01;35:*.tif=01;35:*.xbm=01;35:*.xpm=01;35:*.dl=01;35:*.gl=01;35:*.wmv=01;35:*.aiff=00;32:*.au=00;32:*.mid=00;32:*.mp3=00;32:*.ogg=00;32:*.voc=00;32:*.wav=00;32:*.patch=00;34:*.o=00;32:*.so=01;35:*.ko=01;31:*.la=00;33'
set -gx NPM_CONFIG_FUND false
set -gx DOCKER_SCAN_SUGGEST false
set -gx EDITOR 'cursor --wait'
set -gx STARSHIP_CONFIG "$DOTFILES/config/starship/config.toml"
set -gx CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS 1
set -gx OPENCODE_ENABLE_EXA true
set -gx TF_PLUGIN_CACHE_DIR "$HOME/.terraform.d/plugin-cache"
mkdir -p "$TF_PLUGIN_CACHE_DIR" 2>/dev/null

# PATH
set -gx PATH ./bin "$HOME/bin" "$DOTFILES/bin" $PATH
fish_add_path -m "$HOME/.local/bin" "$HOME/.go/bin" "$HOME/.cargo/bin" "$HOME/Library/pnpm"

if status is-interactive
    # Optional integrations
    test -f "$HOME/.orbstack/shell/init.fish"; and source "$HOME/.orbstack/shell/init.fish"

    # 1Password SSH agent
    if test -e "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
        set -gx SSH_AUTH_SOCK "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    end

    # Tool completion/init
    type -q op; and op completion fish | source
    type -q gh; and gh completion -s fish | source
    type -q flyctl; and flyctl completion fish | source
    type -q mise; and mise activate fish | source
    type -q zoxide; and zoxide init fish | source
    type -q jj; and env COMPLETE=fish jj | source
    if type -q opencode
        set -l _opencode_completion (opencode completion fish 2>/dev/null)
        if string match -qr '(^|\n)\s*complete\s' -- "$_opencode_completion"
            source (printf '%s\n' "$_opencode_completion" | psub)
        end
    end

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
    else if type -q gls
        alias ls 'gls -F --color'
        alias l 'gls -lAh --color'
        alias ll 'gls -l --color'
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

# Functions
function loadenv
    for line in (string match -rv '^\s*(#|$)' < .env)
        set -l parts (string split -m1 '=' -- $line)
        if test (count $parts) -eq 2
            set -gx $parts[1] $parts[2]
        end
    end
end

function c
    cd "$PROJECTS/$argv[1]"
end

function __c_complete_projects
    set -l token (commandline -ct)
    set -l parent (path dirname -- $token)
    set -l partial (path basename -- $token)

    if test "$parent" = "."
        set parent ""
    end

    set -l search_dir "$PROJECTS"
    if test -n "$parent"
        set search_dir "$PROJECTS/$parent"
    end

    if not test -d "$search_dir"
        return
    end

    for entry in "$search_dir"/*
        if test -d "$entry"
            set -l name (path basename -- $entry)
            if string match -q -- "$partial*" "$name"
                if test -n "$parent"
                    printf "%s\n" (string escape -- "$parent/$name/")
                else
                    printf "%s\n" (string escape -- "$name/")
                end
            end
        end
    end
end

complete -c c -e
complete -c c -f -a "(__c_complete_projects)"

function dot
    cd "$DOTFILES"
end

function _pkg_lock_hint --argument-names lockfile manager
    if test -f $lockfile
        echo "Detected $lockfile, did you mean $manager?" >&2
        return 1
    end
    return 0
end

function pnpm
    _pkg_lock_hint bun.lock bun; or return 1
    _pkg_lock_hint yarn.lock yarn; or return 1
    _pkg_lock_hint package-lock.json npm; or return 1
    command pnpm $argv
end

function yarn
    _pkg_lock_hint bun.lock bun; or return 1
    _pkg_lock_hint pnpm-lock.yaml pnpm; or return 1
    _pkg_lock_hint package-lock.json npm; or return 1
    command yarn $argv
end

function e
    if test (count $argv) -eq 0
        if test (uname) = Darwin
            open -a Cursor .
        else if set -q SSH_CLIENT
            cursor-ssh .
        else
            cursor .
        end
    else
        if test (uname) = Darwin
            open -a Cursor $argv
        else if set -q SSH_CLIENT
            cursor-ssh $argv
        else
            cursor $argv
        end
    end
end

function 1p
    op plugin run -- $argv
end

function dcc
    env AWS_PROFILE=depot-Developer \
        CLAUDE_CODE_USE_BEDROCK=1 \
        AWS_REGION=us-west-2 \
        ANTHROPIC_MODEL=opus \
        claude $argv
end

function y
    set -l tmp (mktemp -t yazi-cwd.XXXXXX)
    yazi $argv --cwd-file="$tmp"
    if test -f "$tmp"
        set -l cwd (cat -- "$tmp")
        if test -n "$cwd"; and test "$cwd" != "$PWD"
            cd -- "$cwd"
        end
    end
    rm -f -- "$tmp"
end

function extract --argument-names file
    if not test -f "$file"
        echo "'$file' is not a valid file"
        return 1
    end

    switch $file
        case '*.tar.bz2' '*.tbz2'
            tar -jxvf "$file"
        case '*.tar.gz' '*.tgz'
            tar -zxvf "$file"
        case '*.bz2'
            bunzip2 "$file"
        case '*.dmg'
            hdiutil mount "$file"
        case '*.gz'
            gunzip "$file"
        case '*.tar'
            tar -xvf "$file"
        case '*.zip' '*.ZIP'
            unzip "$file"
        case '*.pax'
            cat "$file" | pax -r
        case '*.pax.Z'
            uncompress "$file" --stdout | pax -r
        case '*.Z'
            uncompress "$file"
        case '*'
            echo "'$file' cannot be extracted/mounted via extract()"
            return 1
    end
end
