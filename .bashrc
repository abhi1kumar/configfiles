# Path ~/.bashrc
# Reference: https://github.com/abhi1kumar/configfiles/.bashrc
# Abhinav Kumar

# For macs (Note: macOS native ls uses -G instead of --color)
export CLICOLOR=1

# ==================================================================================================
# History
# ==================================================================================================
# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# Increase history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# ================================================================================================== 
# Aliases Defintions & Functions
# ==================================================================================================
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ~='cd ~'
alias -- -='cd -'            # Go back to previous directory
alias project='cd ~/project'

# Listing
alias ll='ls -alFh'
alias lt='ls -ltr'           # List by time, newest last
alias la='ls -A'
alias l='ls -CF'

# cd + ls in one command
function cl() {
  cd "$1" && ls -la
}

# Copy to clipboard
alias clipboard='xclip -selection clipboard'

# Reload shell config after editing
alias reload='source ~/.bashrc'

# Claude
alias claude='claude --permission-mode auto'

# SSH / Server Aliases
# Launch tmux in session 0 if session exists, else create new tmux session
alias cvl1="ssh -X -t kumarab6@cvl1.cse.msu.edu 'tmux attach -d -t 0 || tmux new-session -s 0'"
alias cvl2="ssh -X -t kumarab6@cvl2.cse.msu.edu 'tmux attach -d -t 0 || tmux new-session -s 0'"
alias cvl3="ssh -X -t kumarab6@cvl3.cse.msu.edu 'tmux attach -d -t 0 || tmux new-session -s 0'"
alias cvl4="ssh -X -t kumarab6@cvl4.cse.msu.edu 'tmux attach -d -t 0 || tmux new-session -s 0'"
alias cvl5="ssh -X -t kumarab6@cvl5.cse.msu.edu 'tmux attach -d -t 0 || tmux new-session -s 0'"
alias da3="ssh -X -t colligo@pluto-prod-abhinakumar-da3-0 'tmux attach -d -t 0 || tmux new-session -s 0'"
alias coltest="ssh -X -t colligo-test 'tmux attach -d -t 0 || tmux new-session -s 0'"

# Softwares
alias python='/usr/local/bin/python3.10'
alias pip='/usr/local/bin/pip3.10'
alias meld='meld_script(){ /Applications/Meld.app/Contents/MacOS/Meld $* 2>/dev/null & };meld_script'
alias aip="python -m colligo.pluto.sdk.cli"

# ==================================================================================================
# WandB and HF setup
# ==================================================================================================
export WANDB_API_KEY=xxx
export HF_HOME=/group-volume/datasets/
export HF_TOKEN=xxx

# ==================================================================================================
# Conda setup
# ==================================================================================================
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/abhinav/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/abhinav/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/abhinav/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/abhinav/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Alternate, works on server
# eval "$(/home/abhinav/miniconda3/bin/conda shell.bash hook)"

# ==================================================================================================
# Navigate to folder
# ==================================================================================================
aws_bucket=s3://foundry-disney-mickey-mouse-adobe-assets

conda activate gsplat
cd ~/project/gsplat
