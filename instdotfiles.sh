#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="tmux.conf tmux.powerline.conf tmux.conf.solarized.dark bashrc bash_aliases  bash_exports bash_profile bash_logout bash_functions vimrc conkyrc.workstation conkyrc.laptop zshrc oh-my-zsh private Xresources conky"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
echo "Moving any existing dotfiles from ~ to $olddir"
for file in $files; do
    if [ -f ~/.$file ]; then
        mv ~/.$file ~/dotfiles_old/
    fi
    if [ -f $dir/$file ]; then
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    fi
    if [ -d ~/.$file ]; then
        true #mv ~/.$file ~/dotfiles_old/
    fi
    if [ -d $dir/$file ]; then
        #echo "Creating symlink to $file in home directory."
        true #ln -s $dir/$file ~/.$file
    fi
done

#git clone weather icons
cd $HOME/dotfiles/conky/weather
git clone git://github.com/jason0x43/jc-weather.git
ln -s jc-weather/icons/avman/ icons


#Things TODO
#Check if vim is installed, if not print info
#if vim installed, git install all the vim plugins
install_vimplugins () {
    if [[ ! -d ~/.vim/backup ]]; then
        mkdir -p ~/.vim/backup
    fi
    if [[ ! -d ~/.vim/bundle ]]; then
        git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
        vim +PluginInstall +qall
    fi
}

install_zsh () {
# Test to see if zshell is installed.  If it is:
if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
    # Clone my oh-my-zsh repository from GitHub only if it isn't already present
    if [[ ! -d $dir/oh-my-zsh/ ]]; then
        git clone http://github.com/michaeljsmalley/oh-my-zsh.git
    fi
    # Set the default shell to zsh if it isn't currently set to zsh
    if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
        chsh -s $(which zsh)
    fi
else
    # If zsh isn't installed, get the platform of the current machine
    platform=$(uname);
    # If the platform is Linux, try an apt-get to install zsh and then recurse
    if [[ $platform == 'Linux' ]]; then
        sudo apt-get install zsh
        install_zsh
    # If the platform is OS X, tell the user to install zsh :)
    elif [[ $platform == 'Darwin' ]]; then
        echo "Please install zsh, then re-run this script!"
        exit
    fi
fi
}

#install_zsh
install_vimplugins
