HOME_PERM=/sensei-fs-3/users/abhinakumar/
PROJECT_PERM=$HOME_PERM  # This could be same or different

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
