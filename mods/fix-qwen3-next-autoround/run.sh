#!/bin/bash
# Reverts vLLM PR #35156 in the running container.
# That PR broke AutoRound int4 weight loading for Qwen3-Coder-Next, causing
# the model to output gibberish (echoing the input). Reverting restores
# correct outputs. Mirrors @eugr/mods/fix-qwen3-next-autoround.
set -e

echo "Reverting vLLM PR #35156 (AutoRound weight loading fix)"
if curl -L https://patch-diff.githubusercontent.com/raw/vllm-project/vllm/pull/35156.diff \
   | patch -p1 -R -d /usr/local/lib/python3.12/dist-packages; then
  echo "    OK"
else
  echo "    Patch can't be reversed, skipping (likely already not applied)"
fi
