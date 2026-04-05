# ============================================================
# setup.ps1 - Vibe_Code_Project_1
# For Windows users running PowerShell (not Git Bash)
# Usage: .\scripts\setup.ps1
# ============================================================

$ErrorActionPreference = "Stop"

Write-Host "▶ Detected OS: Windows (PowerShell)" -ForegroundColor Cyan

# ── Detect Python ─────────────────────────────────────────────
$PYTHON = $null
foreach ($cmd in @("python3", "python")) {
    if (Get-Command $cmd -ErrorAction SilentlyContinue) {
        $PYTHON = $cmd
        break
    }
}
if (-not $PYTHON) {
    Write-Host ""
    Write-Host "❌ Python not found." -ForegroundColor Red
    Write-Host "   Download from: https://python.org/downloads"
    Write-Host "   Make sure to check 'Add Python to PATH' during install."
    exit 1
}
$version = & $PYTHON --version
Write-Host "▶ Using: $version" -ForegroundColor Cyan

# ── Create virtual environment ────────────────────────────────
Write-Host "▶ Creating virtual environment..." -ForegroundColor Cyan
& $PYTHON -m venv .venv

Write-Host "▶ Activating venv..." -ForegroundColor Cyan
.\.venv\Scripts\Activate.ps1

# ── Install dependencies ──────────────────────────────────────
Write-Host "▶ Upgrading pip..." -ForegroundColor Cyan
pip install --upgrade pip --quiet

Write-Host "▶ Installing runtime dependencies..." -ForegroundColor Cyan
pip install -r requirements.txt --quiet

Write-Host "▶ Installing dev dependencies..." -ForegroundColor Cyan
pip install -r requirements-dev.txt --quiet

# ── Environment file ──────────────────────────────────────────
if (-not (Test-Path ".env")) {
    Copy-Item ".env.example" ".env"
    Write-Host "▶ .env created from .env.example — fill in your secrets!" -ForegroundColor Yellow
} else {
    Write-Host "▶ .env already exists, skipping." -ForegroundColor Gray
}

# ── Done ──────────────────────────────────────────────────────
Write-Host ""
Write-Host "✅ Vibe_Code_Project_1 setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "   Activate venv:    .\.venv\Scripts\Activate.ps1"
Write-Host "   Run locally:      $PYTHON src\main.py"
Write-Host "   Run with Docker:  docker compose up --build"
Write-Host "   Run tests:        pytest"
Write-Host ""
Write-Host "   ⚠️  Pre-commit hooks not yet installed." -ForegroundColor Yellow
Write-Host "   Run these after setting up your git repo:"
Write-Host "      pre-commit install"
Write-Host ""
