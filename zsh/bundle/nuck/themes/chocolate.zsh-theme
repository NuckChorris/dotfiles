PROMPT='%F{224}%n%F{181}@%F{231}%m%F{181}:%F{224}$f%~  %f'
RPROMPT='%f$(vcs_info_wrapper)%f'

LS_COLORS="di=37:ln=1:so=1:pi=1:ex=1:bd=33:cd=35:su=1:sg=1;47:tw=1:ow=1;46"
LSCOLORS="hxCxFxDxGxdxfxGAGhHAHg"

zstyle ":vcs_info:*" formats '%F{224}%b %{181}(%F{231}%a%F{181})%f'
zstyle ":vcs_info:*" formats '%F{224}%b%f'
