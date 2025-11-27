ARG FREQTRADE_VERSION=develop_freqaitorch
FROM ghcr.io/freqtrade/freqtrade:${FREQTRADE_VERSION}

ARG NFI_VERSION=main

# Install git if not already present
USER root
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Switch back to freqtrade user
USER ftuser

# Clone NostalgiaForInfinity strategy
RUN mkdir -p /freqtrade/user_data/strategies && \
    cd /freqtrade/user_data/strategies && \
    git clone https://github.com/iterativv/NostalgiaForInfinity.git && \
    cd NostalgiaForInfinity && \
    git checkout ${NFI_VERSION}

# Create a symlink to the strategies for easier access
RUN cd /freqtrade/user_data/strategies && \
    ln -sf NostalgiaForInfinity/*.py .

WORKDIR /freqtrade
