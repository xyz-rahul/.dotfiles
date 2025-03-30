#!/bin/bash

# Script: fzf_idea_workspace_project_launcher
# Description: Select a workspace project using fzf and open it in IntelliJ IDEA

# Set the base directory where folders are located
WORKSPACE_DIR=~/dev/workspace

# Use fzf to select a directory and display only folder names with a royal blue selection background
SELECTED_DIR=$(find "$WORKSPACE_DIR" -mindepth 1 -maxdepth 1 -type d | sed "s|.*/||" | fzf --color=bg+:#4169e1)

# Check if a directory was selected
if [ -n "$SELECTED_DIR" ]; then
    FULL_PATH="$WORKSPACE_DIR/$SELECTED_DIR"
    echo "Opening in IntelliJ IDEA: $FULL_PATH"
    idea "$FULL_PATH"
else
    echo "No directory selected."
fi

