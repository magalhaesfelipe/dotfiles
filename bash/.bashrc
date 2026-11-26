# Load modular configuration
BASHRC_DIR="$HOME/dotfiles/bash/bashrc"

for f in "$BASHRC_DIR"/*; do 
    if [ ! -d $f ]; then
        c="$BASHRC_DIR/custom/$(basename "$f")"
        [[ -f $c ]] && source $c || source $f
    fi
done

# Load single customization file (if exists)
if [ -f ~/.bashrc_custom ]; then
    source ~/.bashrc_custom
fi

export PATH="/home/y/.local/bin:$PATH"

eval "$(zoxide init bash --cmd s)"

__omp_first=1
__omp_spacer() {
  if [[ -n $__omp_first ]]; then unset __omp_first; else printf '\n'; fi
}
PROMPT_COMMAND="__omp_spacer${PROMPT_COMMAND:+;$PROMPT_COMMAND}"

clear() { command clear; __omp_first=1; }
