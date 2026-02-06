#!/usr/bin/with-contenv bash

# Check if GPU support is enabled
GPU_SUPPORT=$(jq -r '.gpu' /data/options.json)
START_AUTH=$(jq -r '.start_auth' /data/options.json)

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
    export CUDA_VISIBLE_DEVICES=""
    export ROCR_VISIBLE_DEVICES=""
else
    echo "GPU support is enabled. Attempting to use available hardware."
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
