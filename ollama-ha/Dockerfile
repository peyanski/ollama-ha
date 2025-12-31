ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.19
FROM ${BUILD_FROM}

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    jq \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Ollama based on architecture
ARG TARGETARCH
RUN curl -L "https://ollama.com/download/ollama-linux-${TARGETARCH}.tgz" | tar -xz -C /usr/local

ENV HOME=/data
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/data/.ollama/models

RUN mkdir -p /data/.ollama/models

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
