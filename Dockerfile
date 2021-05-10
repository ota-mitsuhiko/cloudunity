FROM ubuntu:18.04

# smash keyboard config
ARG DEBIAN_FRONTEND=noninteractive

# ADD NVIDIA REPO
# RUN add-apt-repository ppa:graphics-drivers
RUN apt-get update && apt-get install -y \
    wget gnupg unzip git-all

RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-ubuntu1804.pin
RUN mv cuda-ubuntu1804.pin /etc/apt/preferences.d/cuda-repository-pin-600
RUN wget http://developer.download.nvidia.com/compute/cuda/11.0.2/local_installers/cuda-repo-ubuntu1804-11-0-local_11.0.2-450.51.05-1_amd64.deb
RUN dpkg -i cuda-repo-ubuntu1804-11-0-local_11.0.2-450.51.05-1_amd64.deb
RUN apt-key add /var/cuda-repo-ubuntu1804-11-0-local/7fa2af80.pub
RUN apt-get update
RUN apt-get -y install cuda


# Install xorg server and xinit BEFORE INSTALLING NVIDIA DRIVER.
RUN apt-get update && apt-get install -y \
    xinit
#FIXME (NO WORKING ON TESLA)
#RUN ubuntu-drivers autoinstall

RUN apt-get update && apt-get install -y \
    mesa-utils x11-apps x11vnc

# for test
RUN apt-get update && apt-get install -y --no-install-recommends \
        firefox openbox

# sound driver and GTK library
# If you want to use sounds on docker, try `pulseaudio --start`
RUN apt-get update && apt-get install -y --no-install-recommends \
      alsa pulseaudio libgtk2.0-0

# novnc
# download websockify as well
RUN wget https://github.com/novnc/noVNC/archive/v1.1.0.zip && \
  unzip -q v1.1.0.zip && \
  rm -rf v1.1.0.zip && \
  git clone https://github.com/novnc/websockify /noVNC-1.1.0/utils/websockify

# Xorg segfault error
# dbus-core: error connecting to system bus: org.freedesktop.DBus.Error.FileNotFound (Failed to connect to socket /var/run/dbus/system_bus_socket: No such file or directory)
# related? https://github.com/Microsoft/WSL/issues/2016
RUN apt-get update && apt-get install -y --no-install-recommends \
      dbus-x11 \
      libdbus-c++-1-0v5

# (3) Run Xorg server + x11vnc + X applications
# see run.sh for details
COPY run.sh /run.sh
CMD ["bash", "/run.sh"]