# Ubuntu 24.04 LTS
FROM ubuntu:noble
ENV container=docker

# Install minimal desktop environment
RUN apt update && DEBIAN_FRONTEND=noninteractive && apt install -y ubuntu-desktop-minimal

# Add an user and give it sudo rights
ARG USERNAME
RUN apt install -y sudo
RUN adduser $USERNAME --disabled-password
RUN usermod -G sudo $USERNAME
RUN echo "Defaults:$USERNAME !requiretty" >> /etc/sudoers.d/$USERNAME
RUN echo "$USERNAME ALL=(ALL)      NOPASSWD: ALL" >> /etc/sudoers.d/$USERNAME
RUN chmod 440 /etc/sudoers.d/$USERNAME

# Install additional packages for PostgreSQL development
RUN apt install -y git
RUN apt install -y build-essential git gdb lcov bison flex \
libkrb5-dev libssl-dev libldap-dev libpam0g-dev python3-dev \
tcl-dev libperl-dev gettext libxml2-dev libxslt1-dev \
libreadline-dev libedit-dev uuid-dev libossp-uuid-dev \
libipc-run-perl perl pkg-config vim locales

# Set the locale
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Download PostgreSQL source code
USER $USERNAME
ARG BUILD_DIR
WORKDIR /home/$USERNAME/
RUN mkdir -p ~/Workplace
WORKDIR /home/$USERNAME/Workplace/
RUN git clone git://git.postgresql.org/git/postgresql.git
RUN mkdir -p $BUILD_DIR
RUN touch /home/$USERNAME/.bash_profile
ENV PG_DIR_PREFIX=/home/$USERNAME/Workplace/$BUILD_DIR
ENV PATH=$PATH:$PG_DIR_PREFIX/bin/

# Visual Studio Code configuration
WORKDIR /home/$USERNAME/Workplace/postgresql/
RUN mkdir -p .vscode
COPY vscode-config/launch.json .vscode/
COPY vscode-config/c_cpp_properties.json .vscode/
COPY vscode-config/tasks.json .vscode/
RUN sudo chown -R $USERNAME:$USERNAME .vscode/
RUN echo ".vscode/*" >> .git/info/exclude

# Copy scripts
RUN mkdir -p scripts
COPY scripts/* scripts/
RUN sudo chown -R $USERNAME:$USERNAME scripts/
RUN sudo chmod +x scripts/*
RUN echo "scripts/*" >> .git/info/exclude

ENV USER=$USERNAME
CMD ["/bin/bash"]
