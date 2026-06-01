#!/bin/bash
set -e
DEST="${WORKSPACE_DIR:-/workspace/vllm}/chat_template.jinja"
cp fixed_chat_template.jinja "$DEST"
# Also write to /workspace/chat_template.jinja in case the serve command runs
# from a different cwd than the mod's WORKSPACE_DIR.
cp fixed_chat_template.jinja /workspace/chat_template.jinja
echo "=======> chat_template.jinja installed at $DEST and /workspace/chat_template.jinja"
