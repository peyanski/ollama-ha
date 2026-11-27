#!/usr/bin/with-contenv bash

# Check if GPU support is enabled
GPU_SUPPORT=$(jq -r '.gpu' /data/options.json)
START_AUTH=$(jq -r '.start_auth' /data/options.json)

# Optional fields may be absent in configurations created before these options.
INTEGRATED_GPU=$(jq -r '.integrated_gpu // false' /data/options.json)
export OLLAMA_CONTEXT_LENGTH="$(jq -r '.context_length // 2048' /data/options.json)"
export OLLAMA_FLASH_ATTENTION="$(jq -r '.flash_attention // false' /data/options.json)"
export OLLAMA_KV_CACHE_TYPE="$(jq -r '.kv_cache_type // "f16"' /data/options.json)"
export OLLAMA_KEEP_ALIVE="$(jq -r '.keep_alive // "5m"' /data/options.json)"

# Ensure persistence
export HOME="/data"
mkdir -p /data/.ollama

# Display Public Key for manual auth
if [ -f "/data/.ollama/id_ed25519.pub" ]; then
    echo "---------------------------------------------------------"
    echo "🔑 OLLAMA PUBLIC KEY (For manual auth):"
    cat /data/.ollama/id_ed25519.pub
    echo "Add this key at: https://ollama.com/settings/keys"
    echo "---------------------------------------------------------"
fi

if [ "$GPU_SUPPORT" != "true" ]; then
    echo "GPU support is disabled. Forcing CPU mode."
    # Ollama recommends an invalid device ID to disable CUDA and ROCm.
    export CUDA_VISIBLE_DEVICES="-1"
    export ROCR_VISIBLE_DEVICES="-1"
    export OLLAMA_VULKAN=false
    export OLLAMA_IGPU_ENABLE=0
else
    echo "GPU support is enabled. Attempting to use available hardware."
    if [ "$INTEGRATED_GPU" = "true" ]; then
        export OLLAMA_VULKAN=true
        export OLLAMA_IGPU_ENABLE=1
    fi
fi

# Auth Flow
if [ "$START_AUTH" == "true" ]; then
    echo "⚠️ STARTING AUTH FLOW"
    echo "Starting Ollama in background to generate signin code..."
    
    # Start Ollama in background
    /usr/local/bin/ollama serve &
    OLLAMA_PID=$!
    
    # Wait for server to be ready
    echo "Waiting for Ollama to start..."
    for i in {1..30}; do
        if curl -s http://localhost:11434 > /dev/null; then
            break
        fi
        sleep 1
    done
    
    echo "---------------------------------------------------------"
    echo "🔐 OLLAMA SIGNIN CODE:"
    # Run signin and capture output. It usually asks to press Enter, so we send a newline.
    # We use 'timeout' to prevent hanging if it waits for input we can't give.
    mkdir -p /root/.ollama # Symlink or copy might be needed if HOME isn't respected by client
    echo "" | timeout 60 /usr/local/bin/ollama signin
    echo "---------------------------------------------------------"
    echo "After authorizing, please RESTART this app."
    
    # Wait for background process
    wait $OLLAMA_PID
    exit 0
fi

echo "Starting Ollama on ${OLLAMA_HOST}"
exec /usr/local/bin/ollama serve
