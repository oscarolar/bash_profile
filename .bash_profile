export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# ~/.bashrc: executed by bash(1) for non-login shells.
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

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/usr/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

parse_git_branch() {

    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'

}

export PS1="\u@\h \W$ "
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;35m\]\u\[\033[01;00m\]@\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

    PS1="\033[1;36m[ \u@\e[0;36m\h ]\e[0;37m - \[[ \w ] \[\033[32m\]\$(parse_git_branch)\[\033[00m\] \033[00m\\n\[\e[30;1m\](\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed 's:     ::g') files, \$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')b\[\e[30;1m\]) \[\e[0m\] $: "
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1="\033[1;33m[ \u@\e[0;34m\h ]\e[0;35m - \[[ \w ] \033[00m\\n\[\e[30;1m\] \[\033[32m\]\$(parse_git_branch)\[\033[00m\] (\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed 's:     ::g') files, \$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/bin/sed 's/total //')b\[\e[30;1m\]) \[\e[0m\] $: "
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
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
alias openerp='sudo su - openerp -s /usr/bin/bash'
alias tweet='twidge update'
alias dm='twidge dmsend'
alias follow='twidge follow'
alias mytweets='twidge lsarchive'
alias tweets='twidge lsrecent'
alias amazonopenerp='ssh -2 -i ~/Descargas/infraestructure.pem ubuntu@ec2-107-21-197-7.compute-1.amazonaws.com'
alias amazonpostgres='ssh -2 -i ~/Descargas/infraestructure.pem ubuntu@ec2-50-16-114-211.compute-1.amazonaws.com'
alias agrinos='ssh -2 -i ~/Descargas/Vauxoo.pem ubuntu@46.51.133.148'
alias pullsub='for dir in ./*; do (cd "$dir" && pwd && git pull); done'
# alias stsub='for dir in ./*; do (cd "$dir" && pwd && git st); done'
alias cosub='for dir in ./*; do (cd "$dir" && pwd && git co 8.0); done'
alias rgrep='grep -r -n '
alias alce='ssh root@erp.casasalce.com'
alias lodi61='ssh root@testinglodigroup.openerp.la'
alias lodi80='ssh root@104.131.91.215'
alias lodibd='ssh root@104.131.91.69'
export PATH=/Library/PostgreSQL/9.3/bin/:$PATH

if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
fi

# export DOCKER_HOST=tcp://192.168.99.100:2376
# export DOCKER_CERT_PATH=/Users/oalca/.docker/machine/certs/
# export DOCKER_TLS_VERIFY=1
export PYTHONPATH=${HOME}/inst/vx/yoytec/odoo:${PYTHONPATH}:/home/inst/vx/yoytec/odoo
[[ -s "$HOME/.qfc/bin/qfc.sh"  ]] && source "$HOME/.qfc/bin/qfc.sh"
alias mydocker="docker --tlsverify --tlscacert=/Users/oalca/gurekeys/ca.pem --tlscert=/Users/oalca/gurekeys/cert.pem --tlskey=/Users/oalca/gurekeys/key.pem -H=gure.vauxoo.com:8548"
alias t2d="travisfile2dockerfile"
function iterm2_print_user_vars() {
  iterm2_set_user_var gitBranch $((git branch 2> /dev/null) | grep \* | cut -c3-)
}

export NVM_DIR="/Users/oalca/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
cosub-method() {
for dir in ./*; do (cd "$dir" && pwd && git co $1); done
}
alias cosub=cosub-method
cleansub-method(){
    for dir in ./*;
    do (cd "$dir" && pwd && git clean -dfx); done

}
alias cleansub=cleansub-method
