#!/usr/bin/with-contenv bash

# Check if GPU support is enabled
GPU_SUPPORT=$(jq -r '.gpu' /data/options.json)

if [ "$GPU_SUPPORT" != "true" ]; then
    echo "GPU support is disabled. Forcing CPU mode."
    export CUDA_VISIBLE_DEVICES=""
    export ROCR_VISIBLE_DEVICES=""
else
    echo "GPU support is enabled. Attempting to use available hardware."
fi

echo "Starting Ollama on ${OLLAMA_HOST}"
exec /usr/local/bin/ollama serve
