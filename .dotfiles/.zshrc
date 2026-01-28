# ZINIT DIRECTORY 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
export ZPFX="$HOME/.local"

# BOOTSTRAP ZINIT
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"
fi

# SOURCE ZINIT
source "${ZINIT_HOME}/zinit.zsh"

# PLUGINS
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# KEYBINDS
bindkey '^ ' autosuggest-accept

# HISTORY
HISTSIZE=1000
HISTFILE=$HOME/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

# COMPLETION
autoload -U compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# SHELL INTEGRATIONS
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

source $HOME/.profile

# PROMPT STYLE
# Bootstraps Oh-My-Posh
export PATH=$PATH:$HOME/.local/bin
if [[ -z "$(command -v oh-my-posh)" ]]; then
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

# Sets Prompt Theme
eval "$(oh-my-posh init zsh --config "$HOME/.dotfiles/void_catppuccin.omp.toml")"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
