[[ "$OSTYPE" == "darwin"* ]] && eval $(/opt/homebrew/bin/brew shellenv)

[ -z "$TMUX"  ] && [[ -n "$KITTY_TMUX" || -n "$WT_SESSION" ]] && {
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

if [[ "$OSTYPE" == "darwin"* ]]; then
  # MacOS
  [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # This loads nvm


  export SDKMAN_DIR=$(brew --prefix sdkman-cli)/libexec
  [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && source "${SDKMAN_DIR}/bin/sdkman-init.sh"
else
  # Linux

  if [ -s "/usr/share/nvm/init-nvm.sh" ]; then
    \. "/usr/share/nvm/init-nvm.sh"
  else
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
  fi

  [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"

  if uname -r | grep -q "microsoft"; then
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
  else
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
  fi
fi

export MANPAGER="nvim +Man\!"
export EDITOR="nvim"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
