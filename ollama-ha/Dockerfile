ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install required packages using apk
RUN apk add --no-cache curl bash ca-certificates \
    && curl -fsSL https://ollama.com/install.sh | sh

ENV HOME=/data
ENV OLLAMA_HOST=0.0.0.0:11434
ENV OLLAMA_MODELS=/data/.ollama/models

RUN mkdir -p /data/.ollama/models

COPY run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]
