# ~/.config/zsh/.zshrc

# Prompt
PROMPT="%F{red}[%f%B%F{3}%n%f%b%F{10}@%f%F{14}%m%f %F{13}%~%f%F{red}]%f$ "
unsetopt prompt_cr prompt_sp

# Case insensitivity
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt MENU_COMPLETE

# Complete aliases
unsetopt complete_aliases

# Disable Ctrl + s
stty stop undef

# History
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh_history

# Ctrl + backspace kill previous word
bindkey '^H' backward-kill-word

# Autocompletion
autoload -Uz compinit
zmodload zsh/complist
compinit
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
zstyle ':completion::complete:*' gain-privileges 1
_comp_options+=(globdots)

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Edit line in vim with Ctrl + e
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Use vim keys in tab complete menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # Initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt

# BEGONE
[ -f ~/.pki ] && rm -rf ~/.pki
[ -f ~/.icons ] && rm -rf ~/.icons
[ -f ~/.java ] && rm -rf ~/.java
[ -f ~/.mono ] && rm -rf ~/.mono
[ -f ~/.scim ] && rm -rf ~/.scim
[ -f ~/.bash_history ] && rm -rf ~/.bash_history
[ -f ~/.python_history ] && rm -rf ~/.python_history

# Functions
# es - edit scripts and config files using fzf
es() { du -a ~/.zprofile ~/.local/bin/* ~/.config/* ~/.local/* | awk '{print $2}' | fzf --layout=reverse --height=40% | xargs -r $EDITOR ;}

# ranger_cd - cd to current dir upon exiting ranger
ranger_cd() {
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
        #exa -l --color=auto --group-directories-first
    fi
    rm -f -- "$temp_file"
}

# open_with_fzf - editor open using fzf
open_with_fzf() {
    find -type f | fzf -m --preview="cat {}" | xargs -ro -d "\n" $EDITOR 2>&-
}
bindkey -s '^O' 'open_with_fzf\n'

# cd_with_fzf - cd using fzf
cd_with_fzf() {
    cd $HOME && cd "$(find -type d | fzf --preview="tree -L 1 {}" --preview-window=:nohidden)" && echo "$PWD" && tree -L 2
}
bindkey -s '^F' 'cd_with_fzf\n'

# locate_with_fzf - cd anywhere on the system using fzf
locate_with_fzf() {
    cd $HOME && cd "$(locate home | fzf -e -i --preview="tree -L 1 {}" --preview-window=:nohidden)" && echo "$PWD" && tree -L 2
}
bindkey -s '^G' 'locate_with_fzf\n'

# Startx
alias startx='startx "$XDG_CONFIG_HOME/x11/xinitrc" -- "$XDG_CONFIG_HOME/x11/xserverrc" vt1'

# Aliases
alias pac='sudo pacman'
#alias ls='ls -hN --color=auto --group-directories-first'
alias ls='exa --icons --color=auto --group-directories-first'
alias la='exa -la --icons --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias df='df -h'
alias du='du -h'
alias cp='cp -rv'
alias rm='rm -rv'
alias mkd='mkdir -pv'
alias v='nvim'
alias sv='sudo nvim'
alias r='ranger_cd'
alias sr='sudo ranger .'
alias cal='calcurse'
alias ytmusic='yt-dlp -i -o "~/Music/%(title)s.%(ext)s" -x --audio-format mp3'
alias ytaudio='yt-dlp -i -f bestaudio'
alias yt720p='yt-dlp -i -f 22'
alias gengrub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
alias gacp='git add . && git commit -m 'Autocommit.' && git push'
alias b='find $HOME/Pictures/Wallpapers/ -name "*jpg" -o -name "*png" | shuf | sxiv -it >/dev/null 2>&1'
alias t='tmux new-session -A -s main'
alias pdf90='pdfjam --landscape --angle 90'
alias pdf270='pdfjam --landscape --angle 270'
alias pdf180='pdfjam --angle 180'

# Shell shortcuts
[ "$(whoami)" != "root" ] && source ~/.config/zsh/shortcutrc

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none
