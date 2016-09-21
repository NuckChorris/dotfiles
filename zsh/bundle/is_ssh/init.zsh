export IS_SSH=0
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  export IS_SSH=1
else
  case $(ps -o comm= -p $PPID) in
    sshd|*/sshd) export IS_SSH=1;;
  esac
fi
