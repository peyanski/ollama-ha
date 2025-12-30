ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.19
FROM ${BUILD_FROM}

# Install required packages
RUN apk add --no-cache curl bash ca-certificates

# Install Ollama based on architecture
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "amd64" ]; then \
        curl -L https://ollama.com/download/ollama-linux-amd64 -o /usr/local/bin/ollama; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        curl -L https://ollama.com/download/ollama-linux-arm64 -o /usr/local/bin/ollama; \
    else \
        echo "Unsupported architecture: $TARGETARCH" && exit 1; \
    fi \
    && chmod +x /usr/local/bin/ollama

ENV HOME=/data
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/data/.ollama/models

RUN mkdir -p /data/.ollama/models

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
