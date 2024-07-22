FROM nvidia/cudagl:10.2-devel-ubuntu16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y libopenexr-dev \
    zlib1g-dev \
    openexr \
    xorg-dev \
    libglfw3-dev \
    software-properties-common \
    sudo \
    vim \
    git \
    apt-transport-https \
    curl \
    software-properties-common \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    && rm -rf /var/lib/apt/lists/*

# Add user
ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000
ARG PASSWORD=user
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID -G sudo $USERNAME && \
    echo $USERNAME:$PASSWORD | chpasswd && \
    echo "$USERNAME   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
USER $USERNAME
WORKDIR /home/$USERNAME/
ENV PATH="/home/$USERNAME/.local/bin:$PATH"

# Install compiler
RUN sudo add-apt-repository ppa:ubuntu-toolchain-r/test \
    && sudo apt-get update \
    && sudo apt-get install -y gcc-4.9 cmake \
    && sudo apt-get --allow-unauthenticated upgrade -y libstdc++6 \
    && sudo apt-get install -y libhdf5-10 libhdf5-serial-dev libhdf5-dev libhdf5-cpp-11


# Install python3.6 and pip
RUN sudo add-apt-repository -y ppa:jblgf0/python \
    && sudo apt-get update \
    && sudo apt-get install -y build-essential python3.6 python3.6-dev \
    && sudo ln -s /usr/bin/python3.6 /usr/local/bin/python3 \
    && curl https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py && python3 get-pip.py --force-reinstall 

# Install pytorch
RUN  pip install torch==1.5.0 torchvision==0.6.0\
    setuptools \
    wheel \
    opencv-python==4.6.0.66 \
    open3d==0.9.0 \
    pyrealsense2==2.51.1.4348 

# Install librealsense
RUN sudo mkdir -p /etc/apt/keyrings \
    && curl -sSf https://librealsense.intel.com/Debian/librealsense.pgp | sudo tee /etc/apt/keyrings/librealsense.pgp > /dev/null \
    && echo "deb [signed-by=/etc/apt/keyrings/librealsense.pgp] https://librealsense.intel.com/Debian/apt-repo `lsb_release -cs` main" | \
    sudo tee /etc/apt/sources.list.d/librealsense.list \
    && sudo apt-get update \
    && sudo apt-get --allow-unauthenticated install -y librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg

# Install cleargrasp
RUN git config --global http.version HTTP/1.1 && \
    git config --global http.postBuffer 524288000 \
    && git clone  https://github.com/Shreeyak/cleargrasp.git --depth=1 \
    && cd cleargrasp \
    && git fetch --unshallow \
    && pip install -r requirements.txt

