#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set -o vi
# .inputrc
# set show-mode-in-prompt on
# set vi-cmd-mode-string "\1\e[2 q\2"
# set vi-ins-mode-string "\1\e[6 q\2"

export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.local/bin
export EDITOR=nvim
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH
export HISTSIZE=10000
export HISTFILESIZE=10000

alias l='exa --icons --color=auto'
alias ls='exa -l --git --icons --color=auto'
alias la='exa -la --git --icons --color=auto'
alias lt='exa -T --level=2 --icons --color=auto'
alias grep='grep --color=auto'
alias sb='source ~/.bashrc'
alias eb='vim ~/.bashrc'
alias pacsyu='sudo pacman -Syy && checkupdates && echo '' && sudo pacman -Syu'
alias vim='nvim'
alias fed='(find /home/gt -type d -not -path "/home/gt/gt.bak/*" -print | fzf --print0) | xargs -0 -r -o nvim'
alias fef='(find /home/gt -type f -not -path "/home/gt/gt.bak/*" -print | fzf --print0) | xargs -0 -r -o nvim'
alias ws='cdfzfselect /home/gt/ws 2'
alias cat='bat'
alias sd='shutdown now'
alias rm='echo "This is not the command you are looking for."; false'
alias rmm='trash-put'
alias yay='yay --answerclean A --answerdiff N --editmenu --answeredit A'
alias cleanpkgcache='yes | yay -Sccd'
alias neo='neo --fps=30 --speed=5 -D -d 0.5 -l 1,1 --charset=ascii'
alias lvim='NVIM_APPNAME=nvim-lazy nvim'

PS1='[\u@\h \W]\$ '

# bind -x '"\ef":"cdfzfselect /home/gt/ws 2"'

cdfzfselect() {
  local base_dir="$1"
  local depth="${2:-1}" # Use default depth of 1 if not provided
  if [ -z "$base_dir" ]; then
    echo "Usage: cdselect <base_directory> [<depth>]"
    return 1
  fi
  selected_dir=$(find "$base_dir" -maxdepth "$depth" -type d -printf '%P\n' | fzf)
  [ -n "$selected_dir" ] && cd "$base_dir/$selected_dir" || return 1
}
eval "$(fzf --bash)"
eval "$(starship init bash)"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash
