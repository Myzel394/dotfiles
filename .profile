paths=(
    "$HOME/.local/bin" 
    "$HOME/.local/share/JetBrains/Toolbox/scripts" 
    "$HOME/.cargo/bin" 
    "$HOME/bin" 
    "$HOME/platform-tools"
)

for new_path in $paths; do
    if [[ -d "$new_path" ]] then
        export PATH="$new_path:$PATH"
    fi
done

export OPENSSL_CONF="/etc/ssl phantomjs"
export NVM_DIR="$HOME/.nvm"

# Conda

if type "$foobar_command_name" > /dev/null; then
    conda init zsh
fi

c() {
    cd "$1"
    if [[ $? -eq 0 ]]; then
        echo -e "\033[3A"
    fi
}

alias n="nvim ."


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('~/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "~/anaconda3/etc/profile.d/conda.sh" ]; then
        . "~/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="~/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

