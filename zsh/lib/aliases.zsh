# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

# Basic directory operations
alias ...='cd ../..'
alias -- -='cd -'

# Show history
alias history='fc -l 1'

# List direcory contents
alias ll='ls -alF'
alias sl=ls # often screw this up

# Protocol handlers
alias http://='open http://'
alias https://='open https://'
alias ftp://='open ftp://'
alias sftp://='open sftp://'
alias irc://='open irc://'

# URL Handlers
alias -s com='noglob url'
alias -s org='noglob url'
alias -s net='noglob url'
alias -s edu='noglob url'
alias -s html='open'

# Compression handlers.  We assume tarballs, not naked compressed files.
alias -s bz2='tar -xjvf'
alias -s gz='tar -xzvf'
alias -s xz='tar -xJvf'

# Image Formats
alias -s gif='open'
alias -s jpg='open'
alias -s jpeg='open'
alias -s png='open'

