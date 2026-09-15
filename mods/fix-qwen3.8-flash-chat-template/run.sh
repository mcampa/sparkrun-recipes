#!/bin/bash
set -e
# sparkrun sets WORKSPACE_DIR to the container cwd (often /workspace), while the
# recipe --chat-template path is /workspace/vllm/chat_template.jinja. Write both.
mkdir -p /workspace/vllm
cp chat_template.jinja /workspace/vllm/chat_template.jinja
cp chat_template.jinja /workspace/chat_template.jinja
if [ -n "${WORKSPACE_DIR:-}" ]; then
  mkdir -p "$WORKSPACE_DIR"
  cp chat_template.jinja "$WORKSPACE_DIR/chat_template.jinja"
fi
echo "=======> chat_template.jinja installed at /workspace/vllm/chat_template.jinja and /workspace/chat_template.jinja"
