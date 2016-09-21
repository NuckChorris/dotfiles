#!/usr/bin/zsh

. theme/manifest.sh
printf '-D%s="%s" ' ${(kvU)theme//:/_}
