FROM codercom/enterprise-base:ubuntu

USER root

ENV DEBIAN_FRONTEND=noninteractive

# Base tools + the ones you kept needing live (nano, socat, less, mysql client)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    zip \
    ca-certificates \
    gnupg \
    software-properties-common \
    nano \
    less \
    socat \
    default-mysql-client \
 && rm -rf /var/lib/apt/lists/*

# WP-CLI, so you can manage the sites from the terminal
RUN curl -o /usr/local/bin/wp \
      https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
 && chmod +x /usr/local/bin/wp

# Docker CLI + compose plugin (talks to the mounted host socket)
RUN install -m 0755 -d /etc/apt/keyrings \
 && curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc \
 && chmod a+r /etc/apt/keyrings/docker.asc \
 && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo $VERSION_CODENAME) stable" \
      > /etc/apt/sources.list.d/docker.list \
 && apt-get update \
 && apt-get install -y docker-ce-cli docker-compose-plugin \
 && rm -rf /var/lib/apt/lists/*

USER coder