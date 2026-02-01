#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract values using jq JSON parser
session_id=$(echo "$input" | jq -r '.session_id // "unknown"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // empty')
model_name=$(echo "$input" | jq -r '.model.display_name // "unknown"')
context_remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Truncate session ID to first 8 characters for brevity
session_short="${session_id:0:8}"

# Get directory basename for display
if [ -n "$cwd" ]; then
    dir_name="${cwd##*/}"
    [ -z "$dir_name" ] && dir_name="/"
else
    dir_name="~"
fi

# Change to working directory for git operations
cd "$cwd" 2>/dev/null || cd "$HOME"

# Get git branch (if in a git repository)
git_branch=""
git_status_icon=""
if git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        git_branch="$branch"
    else
        # Detached HEAD - show short commit hash
        git_branch=$(git rev-parse --short HEAD 2>/dev/null)
    fi
    
    # Check for uncommitted changes
    if [ -n "$(git status --porcelain 2>/dev/null)" ]; then
        git_status_icon=" ●"  # Indicates dirty working tree
    fi
fi

# Build progress bar for context remaining
build_progress_bar() {
    local percentage=$1
    local width=10
    local filled=$((percentage * width / 100))
    local empty=$((width - filled))
    local bar=""
    
    # Determine colour based on percentage
    if [ "$percentage" -gt 50 ]; then
        bar+="\e[1;32m"  # Bright green
    elif [ "$percentage" -gt 25 ]; then
        bar+="\e[1;33m"  # Bright yellow
    else
        bar+="\e[1;31m"  # Bright red
    fi
    
    # Build the bar
    for ((i=0; i<filled; i++)); do bar+="█"; done
    bar+="\e[0;90m"
    for ((i=0; i<empty; i++)); do bar+="░"; done
    bar+="\e[0m"
    
    echo -e "$bar"
}

# Format context remaining with colour and progress bar
context_display=""
if [ -n "$context_remaining" ] && [ "$context_remaining" != "null" ]; then
    # Round to integer
    ctx_int=$(printf "%.0f" "$context_remaining")
    
    progress_bar=$(build_progress_bar "$ctx_int")
    
    # Colour for percentage text
    if [ "$ctx_int" -gt 50 ]; then
        ctx_colour="\e[1;32m"  # Bright green
    elif [ "$ctx_int" -gt 25 ]; then
        ctx_colour="\e[1;33m"  # Bright yellow
    else
        ctx_colour="\e[1;31m"  # Bright red
    fi
    
    context_display="${progress_bar} ${ctx_colour}${ctx_int}%\e[0m"
fi

C_RESET="\e[0m"
C_DIM="\e[0;90m"
C_WHITE="\e[0;37m"
C_BLUE="\e[1;34m"
C_MAGENTA="\e[1;35m"
C_CYAN="\e[1;36m"
C_ORANGE="\e[38;5;208m"
C_PURPLE="\e[38;5;141m"
C_PINK="\e[38;5;213m"
C_GREEN="\e[1;32m"
C_YELLOW="\e[1;33m"

ICON_SESSION="💻"
ICON_FOLDER="📁"
ICON_GIT="🌳"
ICON_MODEL="🧠"
ICON_CONTEXT="🪟"
ICON_DIRTY="●"

output=""

# Session ID (abbreviated) with icon
output+="${C_DIM}${ICON_SESSION} ${C_PURPLE}${session_short}${C_RESET}"

# Separator
output+=" ${C_DIM}│${C_RESET} "

# Current directory with icon
output+="${C_ORANGE}${ICON_FOLDER} ${C_BLUE}${dir_name}${C_RESET}"

# Git branch (if available) with icon
if [ -n "$git_branch" ]; then
    output+=" ${C_DIM}(${C_PINK}${ICON_GIT} ${git_branch}${C_YELLOW}${git_status_icon}${C_DIM})${C_RESET}"
fi

# Separator
output+=" ${C_DIM}│${C_RESET} "

# Model name with icon
output+="${C_CYAN}${ICON_MODEL} ${model_name}${C_RESET}"

# Context remaining (if available) with icon and progress bar
if [ -n "$context_display" ]; then
    output+=" ${C_DIM}│${C_RESET} "
    output+="${C_DIM}${ICON_CONTEXT}${C_RESET} ${context_display}"
fi

printf "%b" "$output"
