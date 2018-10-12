FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# Install some base packages
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    apt-utils git curl vim unzip openssh-client wget \
    build-essential cmake libblas-dev libjpeg-dev zlib1g-dev \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

#
# Python 3.7
#
RUN add-apt-repository ppa:deadsnakes/ppa \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
    python3.7 python3.7-dev python3-pip \
    && pip3 install --no-cache-dir --upgrade pip setuptools \
    && echo "alias python='python3'" >> /root/.bash_aliases \
    && echo "alias pip='pip3'" >> /root/.bash_aliases \
    && rm -rf /var/lib/apt/lists/*

# Lua and Torch7

RUN apt-get update \
    && apt-get install -y --no-install-recommends\
    libhdf5-serial-dev liblmdb-dev sudo \
    && git clone https://github.com/torch/distro.git /torch7 \
    && cd /torch7 \
    && bash install-deps \
    && ./install.sh

# Python packages

RUN pip3 --no-cache-dir install \
    Pillow numpy scikit-learn sklearn scikit-image pandas matplotlib Cython requests \
    jupyter tensorflow-gpu h5py pydot_ng keras torch torchvision pytest sphinx

# Add Jupyter configuration

COPY jupyter_notebook_config.py /root/.jupyter/jupyter_notebook_config.py

# Expose Jupyter port

EXPOSE 8888

# Expose Tensorboard port

EXPOSE 6006

WORKDIR /root
CMD bash
