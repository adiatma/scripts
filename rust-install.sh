#!usr/bin/env bash
check_rust_instalation() {
  source "$HOME/.cargo/env"
  cargo --version
}

install_rust() {
  echo "🚀 install rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  check_rust_instalation
}

if [[ -e "$HOME/.cargo/env" ]]; then
  check_rust_instalation
else
  install_rust
fi

