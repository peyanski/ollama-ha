ARG BUILD_FROM=ghcr.io/home-assistant/amd64-base:3.19

# Stage 1: Gather Ollama binaries
FROM ollama/ollama:0.32.9 as builder

RUN mkdir -p /export/bin /export/lib
RUN cp /bin/ollama /export/bin/ollama 2>/dev/null || true
RUN cp /usr/bin/ollama /export/bin/ollama 2>/dev/null || true
RUN cp /usr/local/bin/ollama /export/bin/ollama 2>/dev/null || true

RUN cp -r /usr/lib/ollama/* /export/lib/ 2>/dev/null || true
RUN cp -r /usr/local/lib/ollama/* /export/lib/ 2>/dev/null || true
RUN cp -r /lib/ollama/* /export/lib/ 2>/dev/null || true

# Stage 2: Final App Image
FROM ${BUILD_FROM}

# Install required packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    jq \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/* || \
    (apk add --no-cache curl jq ca-certificates)

# Copy Ollama binary and runtime libraries into safe paths
COPY --from=builder /export/bin/ollama /usr/local/bin/ollama
COPY --from=builder /export/lib/ /usr/local/lib/ollama/

ENV HOME=/data
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/data/.ollama/models
ENV OLLAMA_CONTEXT_LENGTH=2048
ENV OLLAMA_NUM_PARALLEL=1
ENV OLLAMA_MAX_LOADED_MODELS=1

RUN mkdir -p /data/.ollama/models

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
