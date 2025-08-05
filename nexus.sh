#!/bin/bash
# Nexus CLI Install Script
# by github@bromanprjkt
# Based on: https://docs.nexus.xyz/layer-1/testnet/cli-node#quick-install
# note: these are all official commands from https://docs.nexus.xyz/layer-1/testnet/cli-node#quick-install I just summarize or wrap

echo ""
echo "=========================================================================="
echo "                        Nexus CLI Installation                            "
echo " note:                                                                    "
echo " these are all official commands from                                     "
echo " https://docs.nexus.xyz/layer-1/testnet/cli-node#quick-install            " 
echo " I just summarize or wrap                                                 "
echo "                        by:github@bromanprjkt                             "
echo "=========================================================================="
echo ""
echo "Select your platform:"
echo "1. Linux"
echo "2. macOS"
read -p "Enter choice (1/2): " platform

# Platform-specific dependencies
if [ "$platform" = "1" ]; then
  echo ""
  echo "[+] Updating and installing dependencies for Linux..."
  sudo apt update && sudo apt upgrade -y
  sudo apt install -y build-essential pkg-config libssl-dev git-all protobuf-compiler
elif [ "$platform" = "2" ]; then
  echo ""
  echo "[+] Installing dependencies for macOS..."
  brew install protobuf
else
  echo "[-] Invalid choice. Exiting..."
  exit 1
fi

echo ""
echo "Select Nexus CLI installation method:"
echo "1. Install via GitHub (manual build)"
echo "2. Install via curl script (automatic)"
read -p "Enter choice (1/2): " method

if [ "$method" = "1" ]; then
  echo ""
  echo "[+] Cloning and building Nexus CLI from source..."
  git clone https://github.com/nexus-xyz/nexus-cli.git
  cd nexus-cli/clients/cli || { echo "[-] Failed to enter directory"; exit 1; }

  echo "[+] Installing Rust toolchain..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"

  echo "[+] Building Nexus CLI..."
  cargo build --release || { echo "[-] Build failed"; exit 1; }

  echo "[✓] Build completed successfully."

elif [ "$method" = "2" ]; then
  echo ""
  echo "[+] Installing Nexus CLI using curl script..."
  curl -s https://cli.nexus.xyz/ | sh || { echo "[-] Installation failed"; exit 1; }

  echo "[✓] Installation completed successfully."
else
  echo "[-] Invalid choice. Exiting..."
  exit 1
fi

echo ""
read -p "Enter your Node ID: " node_id

echo ""
echo "[+] Starting Nexus Node..."
nexus-network start --node-id "$node_id"
