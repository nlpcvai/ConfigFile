FROM nvidia/cuda:10.2-cudnn7-devel-centos8  

#ENV http_proxy=http://127.0.0.1:3213
#ENV https_proxy=https://127.0.0.1:3213
#ENV HTTP_PROXY=http://127.0.0.1:3213
#ENV HTTPS_PROXY=https://127.0.0.1:3213
ENV CUDNN_VERSION 8.0.2.39

RUN yum install -y \
    libcudnn8-devel-${CUDNN_VERSION}-1.cuda11.0 \
    sudo \
    git \
    wget \
    curl \
    vim \
    gcc \
    cmake \
    python3 \
    python3-pip \
    python3-virtualenv \
    && yum clean all \
    && rm -rf /var/cache/yum/*

RUN useradd -s /bin/bash -d /home/mason -m -G wheel mason
RUN echo 'mason:l' | chpasswd
RUN echo "root:l" | chpasswd
USER mason
WORKDIR /home/mason
CMD /bin/bash

RUN wget \
    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && bash Miniconda3-latest-Linux-x86_64.sh -bfp \
    && rm -f Miniconda3-latest-Linux-x86_64.sh

RUN mkdir /home/mason/workspace
#RUN unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
