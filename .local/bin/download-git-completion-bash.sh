#!/bin/bash

# Define the target file location
TARGET="$HOME/git-completion.bash"
URL="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"

# Download the file using curl
curl -o "$TARGET" "$URL"

# Check if the download was successful
if [ $? -eq 0 ]; then
  chmod +x "$TARGET"
  echo "Downloaded to: $(realpath "$TARGET")"
else
  echo "Download failed."
  exit 1
fi

