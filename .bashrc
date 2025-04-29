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

export FZF_DEFAULT_OPTS="
	# --color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg:#908caa,bg:#1b1919,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"

export PATH=$PATH:~/go/bin
export PATH=$PATH:~/.local/bin
export EDITOR=nvim
# export BUN_INSTALL="$HOME/.bun"
# export PATH=$BUN_INSTALL/bin:$PATH
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:erasedups

alias l='exa --icons --color=auto'
alias ls='exa -l --icons --color=auto --no-filesize'  # --git --total-size
alias la='exa -la --icons --color=auto --no-filesize' # --git --total-size
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
alias cat='bat -p'
alias sd='shutdown now'
alias rb='sudo reboot now'
alias rm='echo "This is not the command you are looking for."; false'
alias rmm='trash-put'
# alias yay='yay --answerclean A --answerdiff N --editmenu --answeredit A'
alias cleanpkgcache='yes | yay -Sccd'
alias neo='neo --fps=30 --speed=5 -D -d 0.5 -l 1,1 --charset=ascii'
alias neoneo='neo --fps=30 --speed=5 -D -d 0.5 -l 1,1 --charset=ascii -m "Wake up, Neo..."'
alias lvim='NVIM_APPNAME=nvim-lazy nvim'
alias lvimog='NVIM_APPNAME=nvim-lazy-og nvim'
alias tvim='NVIM_APPNAME=nvim-test nvim'
alias oil='vim .'
alias top='btop'
# alias hg='history | grep' # use <C-r> instead
alias cleanhist="awk '!a[$0]++' ~/.bash_history > ~/.bash_history.tmp"

burniso() {
    if [ $# -lt 2 ]; then
        echo "Usage: burniso <path_to_iso_file> <path_to_target_device>"
        echo "Example: burniso path/to/iso-file.iso /dev/disk/by-id/usb-My_flash_drive"
        return 1
    fi
    sudo umount -R "$2" &>/dev/null
    sudo dd bs=4M if="$1" of="$2" conv=fsync oflag=direct status=progress
    sync
}

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

# if command -v wsl.exe &>/dev/null; then
#     echo "wsl ok"
#     # do shits related to wsl
# fi

eval "$(fzf --bash)"
eval "$(starship init bash)"
