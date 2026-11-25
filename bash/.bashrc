#    _               _              
#   | |__   __ _ ___| |__  _ __ ___ 
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__ 
# (_)_.__/ \__,_|___/_| |_|_|  \___|
# 

# -----------------------------------------------------
# Load modular configuration
# -----------------------------------------------------

BASHRC_DIR="$HOME/dotfiles/bash/bashrc"

for f in "$BASHRC_DIR"/*; do 
    if [ ! -d $f ]; then
        c="$BASHRC_DIR/custom/$(basename "$f")"
        [[ -f $c ]] && source $c || source $f
    fi
done

# -----------------------------------------------------
# Load single customization file (if exists)
# -----------------------------------------------------

if [ -f ~/.bashrc_custom ]; then
    source ~/.bashrc_custom
fi


export PATH="/home/y/.local/bin:$PATH"

eval "$(zoxide init bash --cmd s)"

