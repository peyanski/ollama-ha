ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.19

# Use the official Ollama image directly as the base
# This ensures all binaries, runners (llama-server), and libraries are present
FROM ollama/ollama:0.32.9

# Install required packages for HA integration
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    jq \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

ENV HOME=/data
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/data/.ollama/models

RUN mkdir -p /data/.ollama/models

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
