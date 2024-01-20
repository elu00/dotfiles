# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall

zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**'
zstyle :compinstall filename '/home/elu/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# x-forwarding stuff
#export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0

# aliases
alias python='python3'
alias pip='pip3'
alias t='nvim -c "Neorg workspace notes"'
alias update='git add . && git commit -m "stuff" && git push'
function dollar_switch () {
    perl -077pi.bak -e 's/(\s)\$\$(.+?)\$\$/\1\\[\2\\]/sg' ${1} && perl -077pi.bak -e 's/(\s)\$(.+?)\$/\1\\(\2\\)/sg' ${1}
}
function make_format() {
    pdflatex --ini  \&pdflatex  mylatex.ltx *.tex
}

# ignore auxilliary tex files in nvim autocomplete
zstyle ':completion:*:*:nvim:*' file-patterns '^*.(aux|fdb_latexmk|fls|synctex.gz|log|pdf|toc|bbl|blg|out|xdv):source-files' '*:all-files'

cdpath+="/home/elu/math"
cdpath+="/home/elu/repos"
