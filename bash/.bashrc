# if not running interactively, don't do anything
[[ $- == *i* ]] || return

# general environment
if [ -z $TMUX ]; then
    export TERM="xterm-256color-italic"
else
    export TERM="tmux-256color"
fi

export COLORTERM="truecolor"
export TMUX_TMPDIR="$HOME/.tmux"
export ALTERNATE_EDITOR="nvim"
export EDITOR="nvim"
export VISUAL="$EDITOR"
export BROWSER="open -a Safari"
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export CLICOLOR=1
export PATH=/opt/homebrew/bin:$HOME/.local/bin:$HOME/.docker/bin:$PATH

shopt -s cdspell
shopt -s histappend histverify

HISTCONTROL="erasedups:ignoreboth"
HISTIGNORE=?:??
HISTFILE="$HOME/.bash_history"
HISTFILESIZE=10000
HISTSIZE=10000
HISTTIMEFORMAT="%F %T "

PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
PROMPT_DIRTRIM=3

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors -a -r ~/.dircolors ]; then
    eval $(dircolors -b ~/.dircolors)
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# dir navigation shortcuts
# alias -- -='cd -'
alias ..='cd ..'
alias ..2='..; ..'
alias ..3='..2; ..'
alias ..4='..3; ..'
alias ..5='..4; ..'

# some ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# colored GCC warnings and errors
export GCC_COLORS="error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01"

# common app aliases
alias tmux="tmux -2"
alias vim="nvim"

# ansible
export ANSIBLE_INVENTORY="$HOME/.local/share/management/ansible_hosts"
export ANSIBLE_LIBRARY="$HOME/.local/share/management/modules/"
export ANSIBLE_VAULT_PASSWORD_FILE="$HOME/.local/share/management/.vault_pass"

# gpg-agent for ssh auth
unset SSH_AGENT_PID
export SSH_KEY_PATH="$HOME/.ssh/gpg-auth-key.pub"
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
gpg-connect-agent updatestartuptty /bye >/dev/null

PS1='\[\e[1;32m\]█ \h █ \w\n»\[\e[0m\] '
PS1+="$(printf '\033[4 q')"
