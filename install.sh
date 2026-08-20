#!/bin/bash

echo "Installing apt packages...\n"
PACKAGES=(
  curl
  git
  build-essential
  python3-pip
  gimp
  openshot-qt
  nextcloud-desktop
  nautilus-nextcloud
  vlc
  python3-venv
  python3.12-venv
)

echo "Installed apt pacakages\n"

echo "Installing zen-browser..."
curl -fsSL https://github.com/zen-browser/updates-server/raw/refs/heads/main/install.sh | $SHELL

echo "Installing unsloth.ai..."
curl -fsSL https://unsloth.ai/install.sh | UNSLOTH_SKIP_AUTOSTART=1 sh

echo "Installing Hugging Face CLI..."
curl -LsSf https://hf.co/cli/install.sh | bash

echo "Installing multimodal Gemma 4 model..."
hf download unsloth/gemma-4-12B-it-qat-GGUF

echo "Installing GPT OSS 20B model..."
hf download openai/gpt-oss-20b

echo "Installing Qwen Coder coding model..."
hf download unsloth/Qwen2.5-Coder-7B-Instruct-128K-GGUF

echo "Done installing all the pacakages!\n"
