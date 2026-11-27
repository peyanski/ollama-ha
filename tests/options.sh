#!/usr/bin/env bash
set -eu
root=$(cd "$(dirname "$0")/.." && pwd)
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
mkdir -p "$tmp/bin" "$tmp/data"
cat > "$tmp/bin/ollama" <<'EOF'
#!/usr/bin/env bash
env | sort > "$RESULT"
EOF
chmod +x "$tmp/bin/ollama"
sed -e "s|/data|$tmp/data|g" -e "s|/usr/local/bin/ollama|$tmp/bin/ollama|g" "$root/ollama-ha/run.sh" > "$tmp/run.sh"
export PATH="$tmp/bin:$PATH" RESULT="$tmp/result"
check() { grep -Fx "$1" "$RESULT" > /dev/null; }

# Older installations have only the original fields.
printf '%s\n' '{"gpu":false,"start_auth":false}' > "$tmp/data/options.json"
bash "$tmp/run.sh"
check OLLAMA_VULKAN=false
check OLLAMA_IGPU_ENABLE=0
check CUDA_VISIBLE_DEVICES=-1
check ROCR_VISIBLE_DEVICES=-1
check OLLAMA_CONTEXT_LENGTH=2048
check OLLAMA_FLASH_ATTENTION=false
check OLLAMA_KV_CACHE_TYPE=f16
check OLLAMA_KEEP_ALIVE=5m

# gpu=false takes precedence over integrated_gpu=true.
printf '%s\n' '{"gpu":false,"start_auth":false,"integrated_gpu":true}' > "$tmp/data/options.json"
bash "$tmp/run.sh"
check OLLAMA_VULKAN=false
check OLLAMA_IGPU_ENABLE=0

printf '%s\n' '{"gpu":true,"start_auth":false,"integrated_gpu":true,"context_length":65536,"flash_attention":true,"kv_cache_type":"q4_0","keep_alive":"60s"}' > "$tmp/data/options.json"
bash "$tmp/run.sh"
check OLLAMA_VULKAN=true
check OLLAMA_IGPU_ENABLE=1
check OLLAMA_CONTEXT_LENGTH=65536
check OLLAMA_FLASH_ATTENTION=true
check OLLAMA_KV_CACHE_TYPE=q4_0
check OLLAMA_KEEP_ALIVE=60s

# Existing GPU-enabled installations must not opt into integrated GPU.
printf '%s\n' '{"gpu":true,"start_auth":false,"integrated_gpu":false,"flash_attention":false,"kv_cache_type":"q8_0","keep_alive":"0"}' > "$tmp/data/options.json"
env -u OLLAMA_VULKAN -u OLLAMA_IGPU_ENABLE bash "$tmp/run.sh"
! grep -q '^OLLAMA_IGPU_ENABLE=' "$RESULT"
! grep -q '^OLLAMA_VULKAN=' "$RESULT"
check OLLAMA_FLASH_ATTENTION=false
check OLLAMA_KV_CACHE_TYPE=q8_0
check OLLAMA_KEEP_ALIVE=0
echo 'Option propagation checks passed'
