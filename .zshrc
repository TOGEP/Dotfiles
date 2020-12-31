# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# 日本語を使う
export LANG=ja_jp.UTF-8

# golang
export PATH=$PATH:/opt/go/bin
export GOPATH=$HOME/Development/go
export PATH=$PATH:$GOPATH/bin

# history
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt hist_ignore_dups
setopt EXTENDED_HISTORY

# beep
setopt no_beep
setopt nolistbeep
setopt nohistbeep

# auto cd
setopt auto_cd
function chpwd() { exa --icons }

# history search
bindkey "^P" history-beginning-search-backward
bindkey "^N" history-beginning-search-forward

# alias
alias ls='exa --icons'
alias cat='bat'
alias find='fd'
alias vi='vim'
alias vim='nvim'

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
# theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Complement
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Syntax Highlight
zinit light zdharma/fast-syntax-highlighting

zinit light zsh-users/zsh-history-substring-search

zinit light chrissicool/zsh-256color

# bind fg to ctrl+z
fg-ctrl-z(){
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fg-ctrl-z
bindkey '^Z' fg-ctrl-z

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Iterm2 Shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
