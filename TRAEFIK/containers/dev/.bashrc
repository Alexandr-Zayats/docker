# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[31m\]\t\[\033[00m\] \[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
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
alias _ssh='/home/alexandr/SCRIPTS/_ssh.sh'
alias _scp='/home/alexandr/SCRIPTS/_scp.sh'
alias how='/home/alexandr/SCRIPTS/how.sh'
alias genpass='/home/alexandr/SCRIPTS/genpass.sh'
alias ap='ansible-playbook'
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
#if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
#    . /etc/bash_completion
#fi

test -s ~/.alias && . ~/.alias || true

#Java home for debian default install path:
#add ec2 tools to default path
export JAVA_HOME='/usr/lib/jvm/java-1.7.0-openjdk-1.7.0.91-2.6.2.1.el7_1.x86_64/jre'
export EC2_HOME='/usr/local/ec2/ec2-api-tools-1.7.5.1'
export AWS_ACCESS_KEY=AKIAIA7BHUVKC6JLBIYQ
export AWS_SECRET_KEY=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
export PATH=$PATH:$EC2_HOME/bin

shopt -s expand_aliases
#xhost local:Alexandr > /dev/null

#source '/home/alexandr/google-cloud-sdk/path.bash.inc'
#source '/home/alexandr/google-cloud-sdk/completion.bash.inc'

# The next line updates PATH for the Google Cloud SDK.
#if [ -f '/home/alexandr/google-cloud-sdk/path.bash.inc' ]; then source '/home/alexandr/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
#if [ -f '/home/alexandr/google-cloud-sdk/completion.bash.inc' ]; then source '/home/alexandr/google-cloud-sdk/completion.bash.inc'; fi

# Set the url that Rancher is on
export RANCHER_URL=http://rancher.gskins.net:8080
# Set the access key, i.e. username
export RANCHER_ACCESS_KEY=B43FB65AA2349179AFA5
# Set the secret key, i.e. password
export RANCHER_SECRET_KEY=HFDR68KYE25nzWSe9UF7dzbx9RbwPnXxituoe3Co

#export RANCHER_URL=http://rancher.overmind.center:1000
#export RANCHER_ACCESS_KEY=D9D0391682C8F3C07E0A
#export RANCHER_SECRET_KEY=Z5Ro4r8JdbqVAKvNkVsfKyhn9YX5zA1dA662YMaR


PATH="/home/alexandr/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/alexandr/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/alexandr/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/alexandr/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/alexandr/perl5"; export PERL_MM_OPT;
source ~/git-flow-completion.bash
