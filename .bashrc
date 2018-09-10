#~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

#Environment Variable definitions export EDITOR='/usr/bin/vim' export VISUAL='/usr/bin/vim'
	export PROJECT_DIR='/home/hunter/Projects/Scheduler'
  source ~/.work_secretsrc

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=1000
# HISTFILESIZE=2000
HISTSIZE=50
HISTFILESIZE=400

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ldapvi="ldapvi -D uid=$USER,ou=People,dc=osuosl,dc=org -h ldaps://ldap1.osuosl.org"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias config='vim ~/.config/terminator/config'
alias project='vim -S $PROJECT_DIR/Session.vim'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias c="clear"
alias gl='git log --decorate --color --graph'
alias gp='git push origin HEAD'
alias gcm='git checkout master && git pull'
alias grm='git rebase master'
alias grc='git rebase --continue'
alias gs='git status'
alias gcf='git checkout --'
alias sshstart='eval $(ssh-agent)'
alias eb="$EDITOR ~/.bashrc"
alias rs='. ~/.bashrc'
alias resume='vim -S Session.vim'
alias kc='kitchen converge'
alias kl='kitchen login'
alias kt='kitchen test'
alias kd='kitchen destroy'
alias kv='kitchen verify'
alias nb='git checkout master && git pull origin master && git checkout -b'
if [ -f ~/.work_specific ]; then
    . ~/.work_specific
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# This PATH definition must be at the end of this file. Chef does some modification of the PATH through some of the stuff that the OSL had you put in here. This version must be here so that /opt/kitchen/bin is at the beginning, thus overriding the dafault path to kitchen.
export PATH="${HOME}/bin:~/osuosl/zonefiles/scripts/:/opt/kitchen/bin:/usr/local/lib:/usr/lib:$PATH"

HOSTNAME=$(hostname)

cat ~/.msg

export ALREADY_SOURCED="randomstringthatdoesnotmatterintheslightest"


waitfor() {
    shopt -s expand_aliases
    while true; do
        echo "Thank you for being lazy"
        echo "COMMAND: $2"
        echo "WATCHED FILES: $(echo $1)"
# The use of echo here forces the shell to perform globbing and expansions 
        inotifywait -e modify $(echo $1)
        echo "EXECUTING COMMAND"    
        $2  
        sleep 5
        clear
    done
}
# function that takes a list of usernames, and resets their passwords with randomly generated passwords, and puts the password in their homedir
# must be run as root
generate_pw_for (){
  for username in "$@"; do
    pw=$(pwgen 15 1)
    passwd $username <<EOF
$pw
$pw
EOF
    echo "This is a randomly generated password courtesy of OSUOSL. Please delete this after you change your password
    " > /home/${username}/password.deleteme
    echo "$pw" >> /home/${username}/password.deleteme
  done
}

rmtw() {
  sed 's/\s*$//' "$1" > ${1}.bak
  mv ${1}.bak "$1"
}

digs() {
  dig "$1" | grep -A 2 ANSWER
}

digx() {
  dig -x "$1" | grep -A 2 ANSWER
}

shady () {
  ssh-add ~/.ssh/id_rsa_$1
}

d() {
  cd $@ && ls
}

e(){
  $@ 2>&1 >/dev/null & disown
}

mistake() {
  git commit -a --amend <<EOF
:wq
EOF
  git push origin -f HEAD
}
