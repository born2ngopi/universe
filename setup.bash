#!/bin/bash

# Exit jika ada error
set -e

# Cek parameter OS
if [ -z "$1" ]; then
  echo "❌ Usage: ./setup <os>"
  echo "Example: ./setup ubuntu"
  exit 1
fi

OS="$1"

##################################
# install tools                  #
# ################################


##################################
# install nvim                  #
# ################################
# Cek apakah nvim sudah terinstall
if command -v nvim >/dev/null 2>&1; then
  echo "✅ Neovim sudah terinstall: $(nvim --version | head -n 1)"
else
  echo "🔍 Neovim belum terinstall. Melanjutkan instalasi untuk OS: $OS"
  if [ "$OS" = "ubuntu" ]; then
    echo "⬇️ Mengunduh Neovim untuk Linux..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

    echo "🧹 Membersihkan direktori /opt/nvim jika ada..."
    sudo rm -rf /opt/nvim-linux-x86_64

    echo "📦 Mengekstrak ke /opt..."
    sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

    echo "✅ Instalasi selesai. Tambahkan ini ke ~/.bashrc atau ~/.zshrc:"
    echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"'

    echo "🔁 Untuk saat ini, export PATH langsung agar bisa digunakan segera:"
    export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
  elif [ "$OS" = "mac" ]; then
    echo "⬇️ Mengunduh Neovim untuk MacOS with brew.."
    brew install neovim

    echo "✅ Instalasi Neovim selesai"
  elif [ "$OS" = "arc"]; then
    echo "⬇️ Mengunduh Neovim untuk MacOS with brew.."
    sudo pacman -S neovim

    echo "✅ Instalasi selesai"
  else
    echo "❌ OS '$OS' belum didukung untuk instalasi otomatis."
    exit 1
  fi
fi
##################################
# install posting                #
# ################################
if command -v posting >/dev/null 2>&1; then
  echo "✅ Posting sudah terinstall"
else
  echo "⬇️  MDownload and install UV..."
  curl -LsSf https://astral.sh/uv/install.sh | sh

  echo "⬇️  Download and install Posting..."
  uv tool install --python 3.12 posting
  echo "✅ Instalasi Posting selesai"
fi


##################################
# Copy Configration              #
# ################################


##################################
# nvim                           #
# ################################
NVIM_DIR="$HOME/.config/nvim"
NVIM_BACKUP_DIR="$NVIM_DIR-backup"

if [ -d "$NVIM_DIR" ]; then
  echo "⚠️  Folder $NVIM_DIR ditemukan."

  # Jika backup folder sudah ada, tambahkan timestamp agar unik
  if [ -d "$NVIM_BACKUP_DIR" ]; then
    TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    NVIM_BACKUP_DIR="${NVIM_DIR}-backup-${TIMESTAMP}"
    echo "ℹ️  Backup folder sudah ada, akan disimpan sebagai: $NVIM_BACKUP_DIR"
  fi

  mv "$NVIM_DIR" "$NVIM_BACKUP_DIR"
  echo "✅ Folder berhasil di-rename menjadi: $NVIM_BACKUP_DIR"
fi

# copy nvim configuration
cp -r ./nvim $NVIM_DIR

##################################
# posting                        #
# ################################
POSTING_DIR="$HOME/.config/posting/"
POSTING_BACKUP_DIR="$POSTING_DIR-backup"

if [ -d "$POSTING_DIR" ]; then
  echo "⚠️  Folder $POSTING_DIR ditemukan."

  # Jika backup folder sudah ada, tambahkan timestamp agar unik
  if [ -d "$POSTING_BACKUP_DIR" ]; then
    TIMESTAMP=$(date +%Y%m%d-%H%M%S)
    NVIM_BACKUP_DIR="${POSTING_DIR}-backup-${TIMESTAMP}"
    echo "ℹ️  Backup folder sudah ada, akan disimpan sebagai: $POSTING_BACKUP_DIR"
  fi

  mv "$POSTING_DIR" "$POSTING_BACKUP_DIR"
  echo "✅ Folder berhasil di-rename menjadi: $POSTING_BACKUP_DIR"
fi
