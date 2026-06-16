#!/bin/bash
# Installs cohere_melody, the runtime dependency for vLLM's cohere_command4
# reasoning + tool-call parsers (used by CohereLabs/North-Mini-Code-1.0).
# vLLM ships the parser code but doesn't bundle this package, so without
# it `--reasoning-parser cohere_command4` aborts at startup with
# ModuleNotFoundError.
set -e

if python3 -c "import cohere_melody" 2>/dev/null; then
  echo "cohere_melody already installed, skipping"
  exit 0
fi

echo "Installing cohere_melody for cohere_command4 parser"
pip install --no-cache-dir cohere_melody
