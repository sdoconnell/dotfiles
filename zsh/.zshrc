# zsh init and general settings
zstyle ':completion:*' menu select
zstyle ':completion:*' rehash true
zstyle ':completion:*' list-colors
autoload -Uz compinit promptinit
compinit
promptinit
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# directory stack
DIRSTACKFILE="$HOME/.cache/zsh/dirs"
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1]
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}
DIRSTACKSIZE=20
setopt AUTO_PUSHD PUSHD_SILENT PUSHD_TO_HOME
## Remove duplicate entries
setopt PUSHD_IGNORE_DUPS
## This reverts the +/- operators.
setopt PUSHD_MINUS

# file manager keybinds
cdUndoKey() {
  popd
  zle       reset-prompt
  echo
  ls
  zle       reset-prompt
}

cdParentKey() {
  pushd ..
  zle      reset-prompt
  echo
  ls
  zle       reset-prompt
}

zle -N                cdParentKey
zle -N                cdUndoKey
bindkey 'OA'      cdParentKey
bindkey 'OD'      cdUndoKey

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Timestamp format
HIST_STAMPS="yyyy-mm-dd"

# shared command history
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt inc_append_history     # add commands to HISTFILE in order of execution
setopt share_history          # share command history data

# other ENV
if [ -v $TMUX ]; then
  export TERM="xterm-256color-italic"
  export COLORTERM="xterm-256color-italic"
else
  export TERM="tmux-256color"
  export COLORTERM="tmux-256color"
fi

export TMUX_TMPDIR=$HOME/.tmux
export ALTERNATE_EDITOR='nvim'
export EDITOR='nvim'         #for terminal apps that call $EDITOR
export VISUAL="$EDITOR"
export BROWSER='open -a Safari'        #for terminal apps that call $BROWSER
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export TZ='America/Chicago'
export CLICOLOR=1
export PATH=/opt/homebrew/bin:$HOME/.local/bin:$HOME/.docker/bin:$PATH

# dir navigation shortcuts
alias -- -='cd -'
alias ..='cd ..'
alias ..2='..; ..'
alias ..3='..2; ..'
alias ..4='..3; ..'
alias ..5='..4; ..'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# app aliases
alias tmux='tmux -2'
alias vim='nvim'

# ansible
export ANSIBLE_INVENTORY=$HOME/.local/share/management/ansible_hosts
export ANSIBLE_LIBRARY=$HOME/.local/share/management/modules/
export ANSIBLE_VAULT_PASSWORD_FILE=$HOME/.local/share/management/.vault_pass

# gpg-agent for ssh auth
unset SSH_AGENT_PID
export SSH_KEY_PATH="$HOME/.ssh/gpg-auth-key.pub"
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
gpg-connect-agent updatestartuptty /bye >/dev/null

# disable scroll lock
stty -ixon

# file creation default perms
umask 0022

# zsh add-ons
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/opt/zsh-fast-syntax-highlighting/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# prompt
PROMPT="%F{0}%K{2} %F{2}%K{default} %B%m%b %F{default}%K{2} %F{2}%K{default} %(5~|…/%3~|%~)"$'\n'"%F{2}» %f"
#PROMPT+=$'$(printf "\033[4 q")'
ZLE_RPROMPT_INDENT=0

