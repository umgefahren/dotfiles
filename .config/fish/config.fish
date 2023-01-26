if status is-interactive
        fish_vi_key_bindings
        starship init fish | source
        zoxide init fish | source
end

if status --is-login
        set -gx PNPM_HOME /Users/hannesfurmans/Library/pnpm
        set -gx GOROOT (go env GOROOT)
        fish_add_path $PNPM_HOME
        fish_add_path $GOROOT/bin
        fish_add_path (go env GOPATH)/bin
        fish_add_path ~/.cargo/bin/
        fish_add_path ~/.rustup/toolchains/nightly-x86_64-apple-darwin/bin/
        fish_add_path ~/.emacs.d/bin/
        set -gx GPG_TTY (tty)
        set -gx LANG "en_US.UTF-8"
        set -gx LC_CTYPE "en_US.UTF-8"
        set -gx GO111MODULE on
        set -gx BAT_THEME Dracula
        set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix"
        set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
        set -gx LSP_USE_PLISTS true
end

alias edit_fish_config "nvim ~/.config/fish/config.fish"
alias fzf "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
alias icat "kitty +kitten icat"
alias kssh "kitty +kitten ssh"
alias kclip "kitty +kitten clipboard"
alias clipc "fish_clipboard_copy"
alias clipp "fish_clipboard_paste"
alias ll "exa -l"
alias ls "exa"
alias ec "emacsclient --create-frame"
alias ed "emacs --daemon"

function cdd -d "Create a directory and set CWD"
        command mkdir $argv
        if test $status = 0
                switch $argv[(count $argv)]
                        case '-*'

                        case '*'
                                cd $argv[(count $argv)]
                                return
                end
        end
end


function fish_greeting
        echo "Hello Hannes 👋"
end

function resource
        source $HOME/.config/fish/config.fish
end



set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/hannesfurmans/.ghcup/bin # ghcup-env
test -e {$HOME}/.iterm2_shell_integration.fish ; and source {$HOME}/.iterm2_shell_integration.fish

