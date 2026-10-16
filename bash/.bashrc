export PATH="$HOME:$PATH"
# if [ "$PWD" = "$HOME" ]; then
#   cd /c/tree/projects
# fi

# ─────────────────────────────────────────────
# Colors
# ─────────────────────────────────────────────

RESET='\[\e[0m\]'

FG='\[\e[38;2;235;219;178m\]'
GIT='\[\e[38;2;217;119;87m\]'
# FG='\[\e[38;2;245;231;204m\]'
# GOLD='\[\e[38;2;138;90;16m\]'

# ─────────────────────────────────────────────
# Git branch
# ─────────────────────────────────────────────

parse_git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)

    if [[ -n "$branch" ]]; then
        echo "[$branch]"
    fi
}

# ─────────────────────────────────────────────
# Prompt
# ─────────────────────────────────────────────

PS1="${FG}\w${RESET} ${GIT}\$(parse_git_branch)${RESET} "
