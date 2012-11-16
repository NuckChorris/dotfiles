# Configure Terminal
PROMPT="%F{cyan}%n%B%F{black}@%F{blue}%m%F{black}:%b$f%~%B%F{black}$ %f%b"
RPROMPT=$'%B%F{black}$(vcs_info_wrapper)%f%b'
PATH="$PATH:~/bin"
EDITOR="subl -w"
LS_COLORS="di=37:ln=1:so=1:pi=1:ex=1:bd=33:cd=35:su=1:sg=1;47:tw=1:ow=1;46"
LSCOLORS="hxCxFxDxGxdxfxGAGhHAHg"

# Aliases and custom functions
settitle () {
	print -Pn "\e]0;$1\a"
	TITLE="$1"
}
alias ll="ls -alF"
alias vim="vim -c start"
alias ssx="ssh -C -X -c blowfish"
alias steve="ssx plejeck@67.182.84.162 -p 50"
npmgh () {
	open $(npm view $1 repository.url | sed s/git\:/https\:/ | sed s/\\\\.git//)
}
npmv () {
	npm info $1 dist-tags.latest
}

# Add hooks
precmd () {
	if [[ -z $TITLE ]]; then
		settitle "%n@%m:%~"
	else
		settitle "$TITLE (%~)"
	fi
}
preexec () {
	if [[ -z $TITLE ]]; then
		settitle "$2"
	else
		settitle "$TITLE ($2)"
# Hooks to provide for git prompt
setopt prompt_subst
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '%F{242}%s%F{238}-%F{247}%b %F{238}(%F{244}%a%F{238})%f'
zstyle ':vcs_info:*' formats '%F{242}%s%F{238}-%F{247}%b%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

zstyle ':vcs_info:*' enable git cvs svn

# or use pre_cmd, see man zshcontrib
vcs_info_wrapper() {
	vcs_info
	if [ -n "$vcs_info_msg_0_" ]; then
		echo "%{$fg[grey]%}${vcs_info_msg_0_}%{$reset_color%}$del"
	fi
}

# Enable colors
# Replace BSD LS with GNU LS
command -v gls >/dev/null 2>&1 && {
	alias ls="gls --color"
} || {
	alias ls="ls --color"
}
alias grep="grep --color=auto"
alias fgrep="fgrep --color=auto"
alias egrep="egrep --color=auto"

# Keybindings
bindkey "^[[H" beginning-of-line
bindkey "^[[1~" beginning-of-line
bindkey "^[OH" beginning-of-line
bindkey "^[[F"  end-of-line
bindkey "^[[4~" end-of-line
bindkey "^[OF" end-of-line

# Source NVM if installed
command -v ~/nvm/nvm.sh >/dev/null 2>&1 && {
	. ~/nvm/nvm.sh
}

# Set up environment
cd ~/Code
