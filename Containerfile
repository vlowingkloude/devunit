FROM fedora:latest

ARG DEVUNITPASSWORD=password
ARG DEV_USER=dev
ARG EMAIL=nosuch@e.mail

RUN dnf update -y && \
    dnf install -y \
        openssh-server \
        clang \
        git \
        cmake \
        nano \
        libicu \
        libicu-devel \
        java-21-openjdk \
        python3 \
        ninja-build \
    && dnf clean all

RUN ssh-keygen -A

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN useradd -m -s /bin/bash ${DEV_USER} && \
     echo "${DEV_USER}:${DEVUNITPASSWORD}" | chpasswd && \
     echo "${DEV_USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo "root:${DEVUNITPASSWORD}" | chpasswd

USER ${DEV_USER}

WORKDIR /home/${DEV_USER}

RUN git config --global user.name ${DEV_USER}
RUN git config --global user.email ${EMAIL}

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
