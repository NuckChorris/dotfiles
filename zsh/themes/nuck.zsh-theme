#!/bin/zsh

BKG_LIGHT=false

zstyle ':vcs_info:*' actionformats '%F{242}%s%F{238}-%F{247}%b %F{238}(%F{244}%a%F{238})%f'
zstyle ':vcs_info:*' formats '%F{242}%s%F{238}-%F{247}%b%f'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# Left prompt
PROMPT="%F{cyan}%n%B%F{black}@%F{blue}%m%F{black}:%b$f%~%B%F{black}$ %f%b"

# Right prompt
RPROMPT=$'%B%F{black}$(vcs_info_wrapper)%f%b'

# Directory listing colors
# for GNU
LS_COLORS="di=37:ln=1:so=1:pi=1:ex=1:bd=33:cd=35:su=1:sg=1;47:tw=1:ow=1;46"
# for BSD
LSCOLORS="hxCxFxDxGxdxfxGAGhHAHg"
