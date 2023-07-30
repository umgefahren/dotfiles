function not_installed
    if test (count $argv) -lt 2
        echo "function `not_installed` wasn't given enough arguments"
        return
    end
    set --local name $argv[1]
    set --local brew_name $argv[2]
    set --local brew_type formula
    if test (count $argv) -eq 3
        set brew_type $argv[3]
    end
    echo "Command `$name` is not installed"
    echo "Pleas install it with:"
    if test $brew_type = cask
        echo "brew install --cask $brew_name"
    else
        echo "brew install $brew_name"
        if test $brew_type != formula
            echo "From homebrew target: $brew_type"
        end
    end
end

fish_add_path ~/.cargo/bin/


if status is-interactive
    fish_vi_key_bindings
    if type -q starship
        starship init fish | source
    else
        not_installed starship starship
    end
    if type -q zoxide
        zoxide init fish | source
    else
        not_installed zoxide zoxide
    end
    if type -q atuin
        atuin init fish | source
    else
        not_installed atuin atuin
    end
end

fish_add_path /opt/homebrew/bin
fish_add_path $HOMEBREW_PREFIX/opt/make/libexec/gnubin

if type -q go
    # set -gx GOROOT (go env GOROOT)
    set -gx GOROOT (brew --prefix go)/libexec
    fish_add_path $GOROOT/bin
    fish_add_path (go env GOPATH)/bin
else
    not_installed go go
end

if status --is-login
    if type -q pnpm
        set -gx PNPM_HOME /Users/hannesfurmans/Library/pnpm
        fish_add_path $PNPM_HOME
    else
        not_installed pnpm corepack
    end
    if type -q dotnet
        set -gx DOTNET_ROOT /opt/homebrew/opt/dotnet/libexec
        fish_add_path /Users/hannes/.dotnet/tools
    end
    if type -q cargo
        fish_add_path ~/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/
        fish_add_path ~/.cargo/bin/
    else
        echo "INSTALL RUST!!!"
    end
    if type -q emacs
        fish_add_path ~/.emacs.d/bin/
    end
    set -gx IDF_PATH ~/esp/esp-idf
    fish_add_path ~/esp/esp-idf/tools
    fish_add_path /Applications/Xcode.app/Contents/Developer/usr/bin/
    fish_add_path /Users/hannes/Library/Python/3.9/bin
    set -gx PICO_SDK_PATH "~/pico/pico-sdk/"
    set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=$(brew --prefix openssl@1.1)"
    set -gx GPG_TTY (tty)
    set -gx LANG "en_US.UTF-8"
    set -gx LC_CTYPE "en_US.UTF-8"
    set -gx GO111MODULE on
    set -gx BAT_THEME Dracula
    set -gx FZF_DEFAULT_COMMAND "fd --type f --strip-cwd-prefix"
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
    set -gx LSP_USE_PLISTS true
    set -Ux FZF_DEFAULT_OPTS "\
--color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
end


if test $TERM = xterm-kitty
    alias kssh "kitty +kitten ssh"
    alias icat "kitty +kitten icat"
    alias kssh "kitty +kitten ssh"
    alias kclip "kitty +kitten clipboard"
end

alias edit_fish_config "nvim ~/.config/fish/config.fish"
if type -q fzf
    if type -q bat
        alias fzf "fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
    else
        not_installed bat bat
    end
else
    not_installed fzf fzf
end
alias clipc fish_clipboard_copy
alias clipp fish_clipboard_paste

if type -q exa
    alias ll "exa -l"
    alias ls exa
else
    not_installed exa exa
end

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

fish_add_path /Users/hannes/.mix/escripts

set -gx GOOGLE_APPLICATION_CREDENTIALS /Users/hannes/Downloads/aink-news-7bb0bdf554f0.json

#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /Users/hannesfurmans/.ghcup/bin # ghcup-env
test -e {$HOME}/.iterm2_shell_integration.fish; and source {$HOME}/.iterm2_shell_integration.fish

if type -q ipfs
  ipfs commands completion fish | source
end


set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME
set -gx PATH $HOME/.cabal/bin $PATH /Users/hannes/.ghcup/bin # ghcup-env

fish_add_path ~/development/flutter/bin

# set -gx PNPM_HOME "/Users/hannes/Library/pnpm"
# if not string match -q -- $PNPM_HOME $PATH
#   set -gx PATH "$PNPM_HOME" $PATH
# end
