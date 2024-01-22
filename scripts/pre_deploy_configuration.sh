#!/bin/bash

# Install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Add Rust binaries to PATH
source $HOME/.cargo/env

# Verify the installation
rustc --version
cargo --version

# Add WebAssembly target
rustup target list --installed
rustup target add wasm32-unknown-unknown

# Make the script executable
chmod +x "$0"

# Source the updated shell environment
source "$HOME/.profile"   # or use .bashrc, .bash_profile, or .zshrc depending on your shell

echo "Rust is installed successfully, the script is now executable, and WebAssembly target is added."
