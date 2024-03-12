# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# set to 1 to indicate that we're running on limited hardware.
# This will disable some features to reduce resource usage.
export DOTFILES_RUNNING_ON_LIMITED_HARDWARE=0

if [[ "$(uname)" != 'Darwin' && "$(uname --machine)" == 'aarch64' ]]; then
    export DOTFILES_RUNNING_ON_LIMITED_HARDWARE=1
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup
plugins=(
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-autocomplete
    docker
    per-directory-history
    z
    safe-paste
)

if [[ $DOTFILES_RUNNING_ON_LIMITED_HARDWARE -eq 0 ]]; then
    plugins+=(
        jsontools
        conda-zsh-completion
        zsh-better-npm-completion
        tmuxinator
        alias-tips
    )
fi

autoload -U compinit && compinit


# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="nord-extended/nord"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export ZSH="$HOME/.config/oh-my-zsh"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZSH_AUTOSUGGEST_MANUAL_REBIND=true

# Sources
sources=(
    "$ZSH/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
    "$HOME/.config/oh-my-zsh/oh-my-zsh.sh"
    "$HOME/.p10k.zsh"
)

if [[ $DOTFILES_RUNNING_ON_LIMITED_HARDWARE -eq 0 ]]; then
    sources+=(
        # Not required, as this only loads ".cargo/bin" into the PATH
        # "$HOME/.cargo/env"
        "$NVM_DIR/nvm.sh"
        # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
        "$HOME/anaconda3/bin/activate"
    )
fi

for new_source in $sources; do
    if [ -f "$new_source" ]; then
        source "$new_source"
    fi
done

# Brew
if [[ -d "/home/linuxbrew/.linuxbrew/bin" ]]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f "/opt/homebrew/bin/brew" ] ; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Paths
paths=(
    "$HOME/.local/bin"
    "$HOME/.config/scripts"
    "/usr/local/bin"
    "$HOME/bin"
)

if [[ "$DOTFILES_RUNNING_ON_LIMITED_HARDWARE" -eq 0 ]]; then
    paths+=(
        "$HOME/.cargo/bin"
        # Toolbox
        "$HOME/.local/share/JetBrains/Toolbox/scripts"
        "$HOME/platform-tools"
        # MacOS Brew
        "/opt/homebrew/bin"
        "/opt/homebrew/sbin"
    )
fi

for new_path in "${paths[@]}"; do
    if [[ -d "$new_path" ]] then
        export PATH="$new_path:$PATH"
    fi
done

# Docker completion
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# nvm
if [[ "$DOTFILES_RUNNING_ON_LIMITED_HARDWARE" -eq 0 ]]; then
    if [[ -d "/opt/homebrew/opt/nvm" ]]; then
        export NVM_DIR="/opt/homebrew/opt/nvm"
    fi
    if [[ -d "$HOME/.nvm" ]]; then
        export NVM_DIR="$HOME/.nvm"
    fi
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fi

# Custom aliases
alias n="nvim ."

if [[ "$DOTFILES_RUNNING_ON_LIMITED_HARDWARE" -eq 0 ]]; then
    if [ -x "$(command -v neovide)" ]; then
        alias v="WINIT_UNIX_BACKEND=x11 neovide --maximized ."
    fi
fi

if [[ -f "$HOME/.config/secrets.txt" ]]; then
    source "$HOME/.config/secrets.txt"
fi

# Tmux
if [[ -d "$TMUX_PLUGIN_MANAGER_PATH" ]]; then
    tmux-window-name() {
        ($TMUX_PLUGIN_MANAGER_PATH/tmux-window-name/scripts/rename_session_windows.py &)
    }

    add-zsh-hook chpwd tmux-window-name
fi

# Conda
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<

export EDITOR=nvim

alias ll="eza -l --icons --git --binary --group --header --flags --mounts --octal-permissions --changed --created --time-style iso --group-directories-first"
alias la="eza -la --icons --git --binary --group --header --flags --mounts --octal-permissions --changed --created --time-style iso --group-directories-first"

alias full_clear="printf '\033[2J\033[3J\033[1;1H'"

alias dclf="docker container logs --follow --tail 100"

