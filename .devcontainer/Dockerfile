FROM ubuntu:latest

ARG FPM_BIN="https://github.com/fortran-lang/fpm/releases/download/v0.9.0/fpm-0.9.0-linux-x86_64"
ARG GIT_PROMPT="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh"
ARG GIT_COMPLETION="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash"

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install --no-install-recommends \
    git \
    openssh-client \
    unzip \
    python3-pip \ 
    wget \
    gfortran-11 \
    valgrind \
    gdb

RUN pip3 install --no-input fortls fprettify

# Set gfortran-11 and gcc-11 as default 
RUN update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-11 11 && \
  update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-11 11 
  
# Install fpm
RUN cd /tmp && \
  wget --no-check-certificate "${FPM_BIN}" && \ 
  chmod +x $(basename "${FPM_BIN}") && \
  cp $(basename ${FPM_BIN}) /usr/bin && \
  cd /usr/bin && \
  ln -sf /usr/bin/$(basename ${FPM_BIN}) fpm

# Download and setup git command line utilities (prompt and completion scripts)
RUN wget --no-check-certificate -O ~/.git-prompt.sh "${GIT_PROMPT}" && \
    wget --no-check-certificate -O ~/.git-completion.bash "${GIT_COMPLETION}" && \
    echo "source ~/.git-completion.bash" >> ~/.bashrc && \
    echo "source ~/.git-prompt.sh" >> ~/.bashrc && \
    echo "export GIT_PS1_SHOWDIRTYSTATE=1" >> ~/.bashrc && \
    echo "export GIT_PS1_SHOWUNTRACKEDFILES=1" >> ~/.bashrc && \
    echo "export GIT_PS1_SHOWCOLORHINTS=1" >> ~/.bashrc && \
    echo "export PROMPT_COMMAND='__git_ps1 \"\u@\h:\W\" \"\\\$ \"'" >> ~/.bashrc

