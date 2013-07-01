all: git tmux vim zsh
clean: git_clean tmux_clean vim_clean zsh_clean

PWD = $(shell pwd)


# GIT

git: gitconfig gitignore
GIT = $(PWD)/git/

gitconfig:
	ln -s $(GIT)/gitconfig ~/.gitconfig

gitignore:
	ln -s $(GIT)/gitignore_global ~/.gitignore_global

git_clean:
	mv ~/.gitconfig ~/.gitconfig.old
	mv ~/.gitignore_global ~/.gitignore_global.old


# TMUX

tmux: tmux.conf
TMUX = $(PWD)/tmux/

tmux.conf:
	ln -s $(TMUX)/tmux.conf ~/.tmux.conf

tmux_clean:
	mv ~/.tmux.conf ~/.tmux.conf.old


# VIM

vim: vimdir vimrc
VIM = $(PWD)/vim/

vimdir:
	ln -s $(VIM) ~/.vim

vimrc: vimdir
	ln -s ~/.vim/vimrc ~/.vimrc

vim_clean:
	mv ~/.vim/ ~/.vim.old
	mv ~/.vimrc ~/.vimrc.old

# ZSHELL

zsh: zshdir zshrc
ZSH = $(PWD)/zsh/

zshdir:
	ln -s $(ZSH) ~/.zsh

zshrc:
	ln -s ~/.zsh/zshrc ~/.zshrc

zsh_clean:
	mv ~/.zsh/ ~/.zsh.old
	mv ~/.zshrc ~/.zshrc.old

# AWESOME

awesome: awesomedir
AWESOME = $(PWD)/awesome/

awesomedir:
	ln -s $(AWESOME) ~/.config/awesome

awesome_clean:
	mv ~/.config/awesome ~/.config/awesome.old

# XORG

xorg: xmodmap xprofile xresources
XORG = $(PWD)/xorg/

xmodmap:
	ln -s $(XORG)/xmodmap ~/.xmodmap

xprofile:
	ln -s $(XORG)/xprofile ~/.xprofile

xresources:
	ln -s $(XORG)/xresources ~/.xresources

xorg_clean:
	mv ~/.xmodmap ~/.xmodmap.old
	mv ~/.xprofile ~/.xprofile.old
	mv ~/.xresources ~/.xresources.old

