FROM codercom/enterprise-base:ubuntu

USER root

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    zip \
    ca-certificates \
    gnupg \
    software-properties-common \
 && rm -rf /var/lib/apt/lists/*