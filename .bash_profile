# ~/.bash_profile
if [[ "$(uname)" == "Darwin" ]]; then
    export BASH_SILENCE_DEPRECATION_WARNING=1
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

script_dir="$HOME/.local/bin"
export PATH="$PATH:$script_dir"
chmod +x $script_dir/*


if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
fi


# [[ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]] && source "$(brew --prefix)/etc/profile.d/bash_completion.sh"

# [ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!

export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

