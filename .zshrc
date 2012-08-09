# Configure Terminal
PROMPT="%F{cyan}%n%B%F{black}@%F{blue}%m%F{black}:%b$f%~%B%F{black}$ %f%b"
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
	fi
}

# Enable colors
# Replace BSD LS with GNU LS
alias ls="gls --color"
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

# Load in NVM
. ~/nvm/nvm.sh

# Set up environment
cd ~/Code
nvm use 0.6
