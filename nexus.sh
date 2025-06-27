#!/bin/bash

read -p "🧠 Masukkan Node ID: " NODE_ID

if [[ -z "$NODE_ID" ]]; then
  echo "❌ Node ID tidak boleh kosong."
  exit 1
fi

sudo apt update && sudo apt upgrade -y
sudo apt install -y build-essential pkg-config libssl-dev git protobuf-compiler curl

if ! command -v cargo &> /dev/null; then
  echo "🦀 Menginstall Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
fi

echo "⚙️ Menginstall Nexus CLI..."
curl https://cli.nexus.xyz/ | sh
export PATH="$HOME/.nexus/bin:$PATH"

echo "🚀 Menjalankan node Nexus dengan Node ID: $NODE_ID"
nexus-network start --node-id "$NODE_ID"
