FROM nvidia/cuda:10.0-devel-ubuntu18.04

WORKDIR /app

# Dependencies
RUN apt-get update \
    && apt-get install -y \
        build-essential \
        curl \
        g++-7 \
        gcc-7 \
        git \
        libc++-7-dev \
        libffi-dev \
        libgcc-7-dev \
        libsndfile1 \
        libssl-dev \
        python-dev \
        python3-pip \
        python3.7 \
        python3.7-dev \
        python3.7-venv \
        silversearcher-ag \
        vim \
        wget

COPY requirements.txt .

# Torch version is from the handy pytorch website (amazing feature!)
# https://pytorch.org/
RUN python3.7 -m venv python \
  && . python/bin/activate \
  && pip install --upgrade pip \
  && pip install -r requirements.txt \
  && pip install \
      torch==1.6.0+cu101 \
      torchvision==0.7.0+cu101 \
      -f https://download.pytorch.org/whl/torch_stable.html

COPY *.py ./
COPY *.ipynb ./
COPY tfcompat/ ./tfcompat/

