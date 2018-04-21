#!/usr/bin/env bash

#--------------------------------------------------
# Prompt Setting
#--------------------------------------------------
HOST=$(hostname | cut -d. -f1)
if [ "$PS1" ]; then
  PS1="\u_$HOST$ "
  ignoreeof=1
fi

#--------------------------------------------------
# General ENV
#--------------------------------------------------
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad
export CVSEDITOR=vim
export PATH=$HOME/local/bin:$PATH
export PATH=/Applications/CMake.app/Contents/bin:$PATH
export LESS='-R'

#--------------------------------------------------
# General Aliases
#--------------------------------------------------
alias l="ls"
alias ll="l -lh"
alias lsd="l -d */"
alias p="pwd"
alias rl="root -l" 
alias rm~="rm *~"

. ~/local/share/root/build/bin/thisroot.sh 

#--------------------------------------------------
# Functions 
#--------------------------------------------------

bak(){
   if [ -z "$1" ]; then
       echo "yyzh_disk(d)?"

   elif [ "$1" = "d" ]; then
       rsync -avuE -P $HOME/Documents /Volumes/yyzh_disk/Documents
       rsync -avuE -P $HOME/Pictures  /Volumes/yyzh_disk/Pictures
   fi;
}

sl() {
    # cat ~/.ssh/id_dsa.pub | ssh user@remote.com 'cat >> ~/.ssh/authorized_keys'
    hostnames=(cern ihep)
    
    export cern=yuzhen@lxplus.cern.ch
    export ihep=yangyz@lxslc6.ihep.ac.cn

    if [ -z "$1" ]; then
        for hostname in ${hostnames[*]}
	do
	    subst="$hostname"
            echo "    ["$hostname"]" ${!subst}
	done
   	read menu 
    else
    	menu=$1
    fi
    
    for hostname in ${hostnames[*]}
    do
	subst="$hostname"
	if [[ $menu == $hostname ]];
	then
	    echo "Logging into" ${!subst} "..." 
	    ssh -Y ${!subst}
	fi 
    done
}
