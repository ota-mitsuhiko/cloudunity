lspci | grep -i nvidia
sudo apt-get update
ubuntu-drivers devices
sudo apt-get install ubuntu-drivers-common
ubuntu-drivers devices
sudo add-apt-repository ppa:graphics-drivers/ppa
ubuntu-drivers devices
sudo apt-get update
sudo apt-get install nvidia-driver-460
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get -y install cuda-drivers
sudo curl https://get.docker.com | sh
sudo usermod -aG docker $USER