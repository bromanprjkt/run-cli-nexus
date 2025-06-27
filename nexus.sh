#!/bin/bash

DEVELOPER_NAME="bromanprjkt@github"
MARKER_FILE="$HOME/.nexus_installed"

install_nexus_dependencies() {
  echo "👤 Developer: $DEVELOPER_NAME"

  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential pkg-config libssl-dev git protobuf-compiler curl

  if ! command -v cargo &> /dev/null; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
  fi

  curl https://cli.nexus.xyz/ | sh
  export PATH="$HOME/.nexus/bin:$PATH"

  touch "$MARKER_FILE"
  echo "✅ Instalasi selesai oleh $DEVELOPER_NAME"
}

if [ ! -f "$MARKER_FILE" ]; then
  install_nexus_dependencies
else
  export PATH="$HOME/.cargo/bin:$HOME/.nexus/bin:$PATH"
fi

read -p "Masukkan Node ID: " NODE_ID
if [[ -z "$NODE_ID" ]]; then
  echo "❌ Node ID tidak boleh kosong."
  exit 1
fi

echo "🚀 Menjalankan node Nexus dengan Node ID: $NODE_ID"
nexus-network start --node-id "$NODE_ID"
