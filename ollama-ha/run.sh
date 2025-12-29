#!/usr/bin/with-contenv bash
echo "Starting Ollama on ${OLLAMA_HOST}"
exec /usr/local/bin/ollama serve
