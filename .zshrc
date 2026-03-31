eval $(/opt/homebrew/bin/brew shellenv)

[ -z "$TMUX"  ] && [ -n "$KITTY_TMUX" ] && { 
    if tmux has-session 2>/dev/null; then
        echo "There already is existing an existing session. Do you want to continue it?"
        read response

        echo "$response"

        test="hallo"
        test2="tets"

        if [ "$response" = "yes" ]; then
            exec tmux attach && exit 1
        else
            exec tmux new-session && exit 1
        fi
    else
        exec tmux new-session && exit 1
    fi
    exit
}

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

bindkey '^[[1;3C' forward-word
bindkey '^[[1;3D' backward-word

alias gitdifftool="git difftool --staged"
alias gitlog="git log --graph --source --all"
alias ssh-add-auto="ssh-add -t 4h ~/.ssh/signing_key"

export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion


export MANPAGER="nvim +Man\!"

export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
[[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source $(brew --prefix nvm)/nvm.sh


# Created by `pipx` on 2024-08-28 06:47:25
export PATH="$PATH:/Users/simon/.local/bin"
