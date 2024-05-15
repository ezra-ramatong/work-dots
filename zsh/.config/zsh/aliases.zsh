# General
alias la='ls -la'
alias ls='ls --color=auto'
alias md='mkdir'
alias rb='reboot'
alias sn='shutdown now'
alias vim='nvim'

# Config Files
alias zshrc='cd ~/.config/zsh/ && vim .zshrc'
alias aliases='cd ~/.config/zsh && vim aliases.zsh'
alias szsh='exec zsh'
alias nvimc='cd ~/.config/nvim/ && vim init.lua'
alias waybarc='cd ~/.config/waybar/ && vim config.jsonc'
alias swayc='cd ~/.config/sway/ && vim config'

# Network Manager
alias wifi='nmtui'

# fzf
alias ff='cd ~ && ~/.local/bin/explorer.sh'
alias sd='cd ~ && cd $(fd --type d --hidden --exclude .git --exclude node_modules --exclude .cache --exclude .npm --exclude .mozilla --exclude go/pkg/ --exclude .cargo --exclude .rustup --exclude .nvm| fzf --height=70% --border=rounded )'

# File explorer
alias rn='ranger'

# Package Managers

# Pacman
alias pac='sudo pacman -S'
alias pacrs='sudo pacman -Rs'
alias pacu='sudo pacman -Syu'

# Yay
alias yayu='yay -Syu'
alias yayrs='yay -Rs'

# Git
alias ga='git add'
alias gb='git branch'
alias gbd='git branch -d'
alias gc='git commit'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gd='git diff'
alias gl='git log'
alias glo='git log --pretty="oneline"'
alias gm='git merge'
alias gp='git push'
alias gpl='git pull'
alias gpo='git push origin'
alias gposu='git push origin --set-upstream'
alias grmr='git rm -r'
alias gs='git status'

# Custom

# Umuzi
alias up='cd ~/dev/umuzi/projects && rn'
