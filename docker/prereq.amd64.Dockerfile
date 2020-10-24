ARG BASE_IMAGE

# By default, use ubuntu:focal;
FROM $BASE_IMAGE

WORKDIR /build

# install stuff that is needed for compiling LLVM, MLIR and ONNX
RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git cmake ninja-build libprotobuf-dev protobuf-compiler
RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get -y install \
        make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
        libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils \
        libffi-dev liblzma-dev

RUN curl -o ~/miniconda.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
     /opt/conda/bin/conda install -y python=3.7 numpy && \
     /opt/conda/bin/conda clean -ya
ENV PATH /opt/conda/bin:$PATH

#RUN if [ ! -d .pyenv ]; then \
#      git clone git://github.com/yyuu/pyenv.git .pyenv && \
#      git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv; \
#    fi

ENV HOME=/build
#ENV PYENV_ROOT=$HOME/.pyenv
#ENV PATH=$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

#RUN if [ ! -f "./pyenv-installed" ]; then \
#      pyenv install 3.7.0 && \
#      pyenv global 3.7.0 && \
#      pyenv rehash && \
#      touch ./pyenv-installed; \
#    fi

# first install MLIR in llvm-project
RUN mkdir -p bin
ENV PATH=$PATH:/build/bin
COPY ./llvm-project /build/llvm-project

#COPY clone-mlir.sh bin/clone-mlir.sh
#RUN chmod a+x bin/clone-mlir.sh
#RUN if [ ! -d /build/llvm-project ]; then \
#      clone-mlir.sh; \
#    fi

WORKDIR /build/llvm-project/build
RUN if [ ! -f "/build/llvm-project/build/CMakeCache.txt" ]; then \
      cmake -G Ninja ../llvm \
       -DLLVM_ENABLE_PROJECTS=mlir \
       -DLLVM_BUILD_EXAMPLES=ON \
       -DLLVM_TARGETS_TO_BUILD="host" \
       -DCMAKE_BUILD_TYPE=Release \
       -DLLVM_ENABLE_ASSERTIONS=ON \
       -DLLVM_ENABLE_RTTI=ON; \
    fi

RUN if timeout 30m cmake --build . --target -- ${MAKEFLAGS} ; then \
      cmake --build . --target check-mlir; \
    fi
