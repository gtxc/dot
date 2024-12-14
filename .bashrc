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
alias ls='exa -l --icons --color=auto'  # --git
alias la='exa -la --icons --color=auto' # --git
alias lt='exa -T --level=2 --icons --color=auto'
alias grep='grep --color=auto'
alias sb='source ~/.bashrc'
alias eb='vim ~/.bashrc'
alias pacman='sudo pacman'
alias pacsyu='sudo pacman -Syy && checkupdates && echo '' && sudo pacman -Syu'
alias vim='nvim'
alias fed='(find $HOME -type d -not -path "$HOME/gt.bak/*" -print | fzf --print0) | xargs -0 -r -o nvim'
alias fef='(find $HOME -type f -not -path "$HOME/gt.bak/*" -print | fzf --print0) | xargs -0 -r -o nvim'
alias ws='cdfzfselect $HOME/ws 2'
alias cat='bat'
alias sd='shutdown now'
alias rb='sudo reboot now'
alias rm='echo "This is not the command you are looking for."; false'
alias rmm='trash-put'
alias yay='yay --answerclean A --answerdiff N --editmenu --answeredit A'
alias cleanpkgcache='yes | yay -Sccd'
alias neo='neo --fps=30 --speed=5 -D -d 0.5 -l 1,1 --charset=ascii'
alias lvim='NVIM_APPNAME=nvim-lazy nvim'
alias lvimog='NVIM_APPNAME=nvim-lazy-og nvim'
alias oil='vim .'

PS1='[\u@\h \W]\$ '

# bind -x '"\ef":"cdfzfselect $HOME/ws 2"'
# bind -x '"\C-f":"tmux neww -t :0 ~/.local/bin/tmuxsizr"'
# bind -x '"\C-g":"tmux neww -t :0 ~/.local/bin/tmuxwizr"'

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
