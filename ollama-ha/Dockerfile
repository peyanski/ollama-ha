ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.19

# Stage 1: Pull Ollama binary from official image
FROM ollama/ollama:latest as builder

# Stage 2: Final Add-on Image
FROM ${BUILD_FROM}

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    jq \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Copy Ollama binary from official image
COPY --from=builder /bin/ollama /usr/local/bin/ollama

ENV HOME=/data
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/data/.ollama/models

RUN mkdir -p /data/.ollama/models

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
