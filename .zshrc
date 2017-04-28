SAVEHIST=2000
HISTFILE=~/.zsh_history
setopt prompt_subst
setopt share_history


autoload -Uz vcs_info

zstyle ':vcs_info:*' actionformats \
	    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats       \
	    '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

zstyle ':completion:*' use-cache on


vcs_info_wrapper() {
	  vcs_info
	    if [ -n "$vcs_info_msg_0_" ]; then
		        echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
	    fi
  }
PROMPT=$'%n@%~$(vcs_info_wrapper)$ '

setopt histignorealldups sharehistory
autoload -Uz compinit
compinit

tcsh-backward-delete-word() {
	  local WORDCHARS="${WORDCHARS:s@/@}"
	  zle backward-delete-word
}
zle -N tcsh-backward-delete-word

bindkey '^W' tcsh-backward-delete-word

fpath=(/home/earlzero/.zsh/gradle-completion $fpath)
