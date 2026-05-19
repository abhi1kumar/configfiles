# Sample Run:
# bash linux_setup.sh --paths
# bash linux_setup.sh --basic
# bash linux_setup.sh --sshd
# bash linux_setup.sh --paths --basic --sshd
#
# Sets up a new Linux environment in three stages:
#     --paths       - Symlink home/project dirs and dotfiles (.bashrc, .ssh, .aws, .bash_profile)
#     --basic       - apt-get packages + Miniconda install + ftp/da3 conda envs
#     --sshd        - Start custom SSHD + ws-bridge, verify ports, print connection URL

# Read Arguments
TEMP=`getopt -o h --long help,paths,basic,sshd -n 'linux_setup.sh' -- "$@"`

eval set -- "$TEMP"

HELP=false
PATHS=false
BASIC=false
SSHD=false
ERROR=false

if [ "$#" -eq 1 ] ; then
    HELP=true
fi

while true ; do
    case "$1" in
        -h|--help         ) HELP=true          ; shift ;;
        --paths           ) PATHS=true         ; shift ;;
        --basic           ) BASIC=true         ; shift ;;
        --sshd            ) SSHD=true          ; shift ;;
        --                ) shift ; break ;;
        *                 ) ERROR=true ; break ;;
    esac
done

if [ "$ERROR" = true ] ; then
    echo "Error: Invalid argument"
    HELP=true
fi

if [ "$HELP" = true ] ; then
    echo "Usage: linux_setup.sh [OPTIONS]"
    echo "Options:"
    echo "  -h, --help        Display this help message"
    echo "  --paths           Set up symlinks for home, project, dotfiles, SSH"
    echo "  --basic           apt-get packages + Miniconda + conda envs"
    echo "  --sshd            Start custom SSHD + ws-bridge and print connection info"
    return
fi

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------
if [ "$PATHS" = true ] ; then
    HOME_PERM=/sensei-fs-3/users/abhinakumar/
    PROJECT_PERM=$HOME_PERM/project  # This could be same or different

    cd ~
    ln -sfn $HOME_PERM home_perm
    ln -sfn $PROJECT_PERM project

    ln -sfn home_perm/.bashrc .bashrc
    ln -sfn home_perm/.bash_history .bash_history
    ln -sfn home_perm/.vscode .vscode-server

    # SSH and Bash_profile
    rm -rf .ssh
    rm .bash_profile
    ln -sfn home_perm/.ssh .ssh
    ln -sfn home_perm/.aws .aws
    ln -sfn home_perm/.bash_profile .bash_profile

    # Use the same cache
    # rm -rf .cache
    # ln -sfn home_perm/.cache .cache

    # Set Claude
    curl -fsSL https://claude.ai/install.sh | bash
    ln -sfn ~/project/configfiles/CLAUDE.md .claude/CLAUDE.md
fi

# ---------------------------------------------------------------------------
# Basic Install
# ---------------------------------------------------------------------------
if [ "$BASIC" = true ] ; then
    # Update and install basic softwares
    sudo apt-get update
    sudo apt-get install curl ffmpeg git htop screen tmux unzip vim zip -y

    # Setup Conda
    cd ~
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh
    source ~/.bashrc

    conda create -n ftp python=3.10 -y
    conda activate ftp
    conda install conda-forge::rsync -y
    conda deactivate

    conda create -n da3 python=3.12 -y
    conda activate da3
fi

# ---------------------------------------------------------------------------
# SSHD
# ---------------------------------------------------------------------------
if [ "$SSHD" = true ] ; then
    # Setup SSHD
    sudo mkdir -p /run/sshd
    sudo /usr/sbin/sshd -f ~/.ssh/custom_sshd/sshd_config
    nohup python3 ~/.ssh/custom_sshd/ws-bridge.py --port 8005 > /tmp/ws-bridge.log 2>&1 &
    echo $! > ~/.ssh/custom_sshd/ws-bridge.pid
    # Add public key to authorized_keys only if not already present to avoid duplicates
    grep -qxF "$(cat ~/.ssh/id_rsa.pub)" ~/.ssh/custom_sshd/authorized_keys || cat ~/.ssh/id_rsa.pub >> ~/.ssh/custom_sshd/authorized_keys

    netstat -tlnp | grep 2222
    netstat -tlnp | grep 8005
    ssh -p 2222 -o StrictHostKeyChecking=no colligo@127.0.0.1 "echo ok"
    echo "https://${HOSTNAME}-8005.or2.colligo.dev"

    # Add to local ~/.ssh/config
    # Host colligo-test
    #     HostName pluto-prod-abhinakumar-devcol-coltest-1-0-8005.or2.colligo.dev
    #     User colligo
    #     ProxyCommand python3 "/Users/abhinav/custom_ssh_proxy/ssh-tunnel-access-main/ws-proxy.py" wss://%h
    #     StrictHostKeyChecking no
    #     UserKnownHostsFile /dev/null
fi
