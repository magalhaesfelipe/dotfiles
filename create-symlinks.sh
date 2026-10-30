# Link the dotfiles config directories to the local .config/ directory using the command `ln`:
# ln -s <source_dir> <destination_dir>

# Example with individual directories kitty/nvim/bash
# ln -s ~/example/dotfiles/kitty ~/.config/kitty
# ln -s ~/example/dotfiles/nvim ~/.config/nvim
# ln -s ~/example/dotfiles/bash ~/.config/bash


# Command that creates the symbolic links(symlinks) for many directories at once
mkdir -p ~/.config && for dir in kitty nvim fastfetch; do
ln -sfnT "$HOME/dotfiles/$dir" "$HOME/.config/$dir"
done
