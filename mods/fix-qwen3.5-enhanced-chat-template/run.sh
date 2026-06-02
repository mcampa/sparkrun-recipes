#!/bin/bash
# Installs the qwen3.5-enhanced chat template from allanchan339's
# vLLM-Qwen3-3.5-3.6-chat-template-fix repo into the workspace so that
# `--chat-template qwen3.5-enhanced.jinja` resolves at vllm serve time.
set -e
cp qwen3.5-enhanced.jinja "$WORKSPACE_DIR/qwen3.5-enhanced.jinja"
echo "=======> installed qwen3.5-enhanced.jinja; use --chat-template qwen3.5-enhanced.jinja"
