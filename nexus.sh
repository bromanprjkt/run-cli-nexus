#!/bin/bash

echo "🧠 Selamat datang di installer Nexus CLI"
echo "📦 Siapkan sistem untuk menjalankan node"

echo ""
echo "Pilih lingkungan sistem operasi kamu:"
echo "1. Linux (Ubuntu/Debian)"
echo "2. macOS"
read -p "Masukkan pilihan (1/2): " OS_CHOICE

if [[ "$OS_CHOICE" == "1" ]]; then
  echo "🖥️ Menyiapkan untuk Linux..."

  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential pkg-config libssl-dev git-all protobuf-compiler curl

elif [[ "$OS_CHOICE" == "2" ]]; then
  echo "🍏 Menyiapkan untuk macOS..."

  if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew belum terpasang. Silakan install Homebrew dulu:"
    echo "→ https://brew.sh"
    exit 1
  fi

  brew install protobuf curl git

else
  echo "❌ Pilihan tidak valid!"
  exit 1
fi

if ! command -v cargo &> /dev/null; then
  echo "🦀 Menginstall Rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "🦀 Rust sudah terpasang, skip."
fi

echo ""
echo "Pilih cara install Nexus CLI:"
echo "1. Install via GitHub (build manual)"
echo "2. Install via curl script (otomatis)"
read -p "Masukkan pilihan (1/2): " INSTALL_METHOD

if [[ "$INSTALL_METHOD" == "1" ]]; then
  echo "📥 Clone dan build manual Nexus CLI..."
  git clone git@github.com:nexus-xyz/nexus-cli.git
  cd nexus-cli/clients/cli || exit 1
  cargo build --release
  cd -
elif [[ "$INSTALL_METHOD" == "2" ]]; then
  echo "📦 Menginstall Nexus CLI via curl..."
  curl https://cli.nexus.xyz/ | sh
else
  echo "❌ Pilihan tidak valid untuk metode install."
  exit 1
fi

export PATH="$HOME/.cargo/bin:$HOME/.nexus/bin:$PATH"

read -p "🧠 Masukkan Node ID kamu: " NODE_ID
if [[ -z "$NODE_ID" ]]; then
  echo "❌ Node ID tidak boleh kosong."
  exit 1
fi

echo "🚀 Menjalankan node dengan Node ID: $NODE_ID"
nexus-network start --node-id "$NODE_ID"
