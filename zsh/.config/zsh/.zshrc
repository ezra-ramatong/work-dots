autoload -Uz add-zsh-hook
autoload -Uz compinit
compinit
autoload -Uz vcs_info
precmd() { vcs_info }

# Some Magic?
autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# VCS
zstyle ':vcs_info:git:*' formats '%b '
# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats       '( %b%u%c)'
zstyle ':vcs_info:git:*' actionformats '( %b|%a%u%c)'

# Completion
zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/work/.config/zsh/.zcompdump'

# Options
autoload -Uz colors && colors
setopt PROMPT_SUBST
PROMPT='%B%F{yellow}  Grand Term  %f%b '
RPROMPT='%F{green}%~%f %F{red} ${vcs_info_msg_0_}%f'
HISTFILE=~/.config/zsh/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt autocd
setopt auto_menu
setopt menu_complete
unsetopt beep
bindkey -v

# Aliases
source $HOME/.config/zsh/aliases.zsh

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
