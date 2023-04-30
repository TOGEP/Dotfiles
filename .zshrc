# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
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

# clangd
export PATH=$PATH:/Library/Developer/CommandLineTools/usr/bin

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
alias tf='terraform'
alias tfmt='terraform fmt -recursive'

fpath=(
  ${HOME}/.zsh/completions
  ${fpath}
)

# fool proof
# terraform destroy -help も使えなくなるのが玉に瑕
function terraform() {
  if [ "$1" = "destroy" ]; then
    if [[ ! "$*" =~ "-target=" ]]; then
      echo "Error: Terraform destroy requires a target. Use '-target=RESOURCE_TYPE.RESOURCE_NAME'"
      return 1
    fi
  fi
  command terraform "$@"
}

autoload -Uz compinit
compinit

### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/z-a-rust \
    zdharma-continuum/z-a-as-monitor \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-bin-gem-node

### End of Zinit's installer chunk
# theme
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Completion
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light marlonrichert/zsh-autocomplete

# Syntax Highlight
zinit light zdharma-continuum/fast-syntax-highlighting

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

# zsh completion
# bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
zstyle ':autocomplete:history-search-backward:*' list-lines 16
zstyle ':autocomplete:history-incremental-search-backward:*' list-lines 16

# k8s completion
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# aws completion
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Iterm2 Shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
