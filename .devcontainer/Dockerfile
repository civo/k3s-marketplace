FROM mcr.microsoft.com/devcontainers/go:1-1.21-bullseye

# Install additional tools
RUN apt-get update && apt-get install -y \
    curl \
    git \
    && rm -rf /var/lib/apt/lists/*


ARG CIVO_VERSION=1.0.89

# From https://itnext.io/building-multi-cpu-architecture-docker-images-for-arm-and-x86-1-the-basics-2fa97869a99b
ARG TARGETOS
ARG TARGETARCH

# civo cli
RUN curl -Lo /tmp/civo.tar.gz "https://github.com/civo/cli/releases/download/v${CIVO_VERSION}/civo-${CIVO_VERSION}-linux-${TARGETARCH}.tar.gz" \
  && tar -xzf /tmp/civo.tar.gz -C /tmp civo \
  && sudo mv /tmp/civo /usr/local/bin/civo \
  && sudo chmod 755 /usr/local/bin/civo \
  && rm /tmp/civo*

# Install Dagger CLI
RUN curl -L https://dl.dagger.io/dagger/install.sh | sh

# Set up environment variables
ENV PATH="/root/.dagger/bin:${PATH}"


