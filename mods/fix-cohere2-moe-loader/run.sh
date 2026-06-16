#!/bin/bash
# Replaces the in-container Cohere2MoE loader with the upstream vLLM main
# version. The vLLM build from 2026-06-03 (commit ace95c9cf) ships a loader
# that derives layer layout from first_k_dense_replace alone and uses the
# old FusedMoE.make_expert_params_mapping helper. For
# CohereLabs/North-Mini-Code-1.0-fp8 (first_k_dense_replace=1, FP8
# compressed-tensors) this routes the dense layer-0 down_proj weight through
# the expert mapping and crashes with:
#   KeyError: 'layers.0.mlp.down_proj.weight'
# Upstream main has been refactored to read config.mlp_layer_types (with a
# fallback that synthesises it from first_k_dense_replace) and to use the new
# fused_moe_make_expert_params_mapping helper — both fix the loader for this
# checkpoint. Once the container is rebuilt from a newer vLLM main, this mod
# becomes a no-op and can be dropped.
set -e

TARGET=/usr/local/lib/python3.12/dist-packages/vllm/model_executor/models/cohere2_moe.py
SRC="$(dirname "$0")/cohere2_moe.py"

if [[ ! -f "$TARGET" ]]; then
  echo "Target $TARGET not present — vLLM layout changed, skipping"
  exit 0
fi

if cmp -s "$SRC" "$TARGET"; then
  echo "cohere2_moe.py already matches upstream, skipping"
  exit 0
fi

echo "Patching $TARGET with upstream vLLM main cohere2_moe.py"
cp "$TARGET" "$TARGET.sparkrun-bak"
install -m 0644 "$SRC" "$TARGET"
echo "    OK (backup at $TARGET.sparkrun-bak)"
