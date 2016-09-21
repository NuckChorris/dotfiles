PROMPT='%F{2}%n%F{8}@%F{9}%m%F{8}:%F{4}$f%~  %f'
RPROMPT='%f$(vcs_info_wrapper)%f'

LS_COLORS="di=37:ln=1:so=1:pi=1:ex=1:bd=33:cd=35:su=1:sg=1;47:tw=1:ow=1;46"
LSCOLORS="hxCxFxDxGxdxfxGAGhHAHg"

zstyle ":vcs_info:*" formats '%F{2}%b %F{9}(%F{11}%a%F{9})%f'
zstyle ":vcs_info:*" formats '%F{2}%b%f'
