#!/usr/bash

DOTFILES=$HOME/.dotfiles
BACKUP_DIR=$HOME/dotfiles-backup

echo -e "\n"
echo '\\\\\\Creating symlinks\\\\\\'
echo "============================="


linkables=$( find -H "$DOTFILES" -maxdepth 3 -name '*symlink' )
for file in $linkables ; do
    target="$HOME/.$( basename "$file" '.symlink' )"      #Creates file to link to
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... moving to backup"
        mv $target $BACKUP_DIR
    fi
    ln -s "$file" "$target"
done

echo -e "\n"
echo '\\\\\\ Installing Config Files\\\\\\'
echo "===================================="

config_files=$( find "$DOTFILES/config" -maxdepth 1) #2>/dev/null )
for config in $config_files; do
    target="$HOME/.config$( basename "$config" )"
    if [ -e "$target" ]; then
        echo "~${target#$HOME} already exists... moving to backup"
        mv $target $BACKUP_DIR
    fi
    ln -s "$config" "$target"
done



echo -e "\n"
echo '\\\\\\ Installing Vim Files \\\\\\'
echo "===================================="
VIMFILES=$HOME/.vim
VIMDOTFILES=$DOTFILES/vim
if [ -d "$VIMFILES" ]; then
    echo "~$VIMFILES already exists... moving to backup"
    mv $VIMFILES $BACKUP_DIR
fi

mkdir VIMDOTFILES
ln -s VIMDOTFILES VIMFILES

echo "Done creating symlinks!!"






