HOME_PERM=/gpfs-volume/
PROJECT_PERM=/group-volume/Img-Eval/a.kumar4/project

cd ~
ln -sfn $HOME_PERM/.bashrc .bashrc
ln -sfn $HOME_PERM/.bash_history .bash_history
ln -sfn $HOME_PERM/.vscode-server .vscode-server
ln -sfn $PROJECT_PERM project

# SSH and Bash_profile
rm -rf .ssh
rm .bash_profile
ln -sfn $HOME_PERM/ssh .ssh
ln -sfn $HOME_PERM/.bash_profile .bash_profile

rm -rf .cache
ln -sfn /gpfs-volume/.cache .cache

# Update and install basic softwares
sudo apt-get update
sudo apt-get install curl ffmpeg git htop screen tmux unzip vim zip -y
