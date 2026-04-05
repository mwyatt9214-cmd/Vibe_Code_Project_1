#!/usr/bin/env bash
# ============================================================
# setup.sh — Vibe_Code_Project_1
# Compatible with: macOS, Linux, Windows (Git Bash or WSL)
# Usage: bash scripts/setup.sh
# ============================================================

set -e

# ── Detect OS ────────────────────────────────────────────────
OS="unknown"
case "$(uname -s)" in
  Darwin)               OS="mac" ;;
  Linux)                OS="linux" ;;
  MINGW*|MSYS*|CYGWIN*) OS="windows" ;;
esac
echo "▶ Detected OS: $OS"

# ── Detect Python ────────────────────────────────────────────
if command -v python3 &>/dev/null; then
  PYTHON=python3
elif command -v python &>/dev/null; then
  PYTHON=python
else
  echo ""
  echo "❌ Python not found."
  echo "   Mac:     brew install python  OR  https://python.org/downloads"
  echo "   Windows: https://python.org/downloads  (check 'Add to PATH')"
  exit 1
fi
echo "▶ Using: $($PYTHON --version)"

# ── Detect venv activation path (Windows vs Mac/Linux) ───────
if [ "$OS" = "windows" ]; then
  ACTIVATE=".venv/Scripts/activate"
else
  ACTIVATE=".venv/bin/activate"
fi

# ── Create virtual environment ────────────────────────────────
echo "▶ Creating virtual environment..."
$PYTHON -m venv .venv

echo "▶ Activating venv..."
source "$ACTIVATE"

# ── Install dependencies ──────────────────────────────────────
echo "▶ Upgrading pip..."
pip install --upgrade pip --quiet

echo "▶ Installing runtime dependencies..."
pip install -r requirements.txt --quiet

echo "▶ Installing dev dependencies..."
pip install -r requirements-dev.txt --quiet

# ── Environment file ──────────────────────────────────────────
if [ ! -f .env ]; then
  cp .env.example .env
  echo "▶ .env created from .env.example — fill in your secrets!"
else
  echo "▶ .env already exists, skipping."
fi

# ── Done ──────────────────────────────────────────────────────
echo ""
echo "✅ Vibe_Code_Project_1 setup complete!"
echo ""
if [ "$OS" = "windows" ]; then
  echo "   Activate venv:    source .venv/Scripts/activate"
else
  echo "   Activate venv:    source .venv/bin/activate"
fi
echo "   Run locally:      $PYTHON src/main.py"
echo "   Run with Docker:  docker compose up --build"
echo "   Run tests:        pytest"
echo ""
echo "   ⚠️  Pre-commit hooks not yet installed."
echo "   Run these after setting up your git repo:"
echo "      pre-commit install"
echo ""
