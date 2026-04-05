# Vibe_Code_Project_1

> Python project with venv, Docker, and CI/CD via GitHub Actions.
> Works on **macOS, Linux, and Windows**.

---

## Quick Start

### macOS / Linux / Windows (Git Bash or WSL)
```bash
cd Vibe_Code_Project_1
bash scripts/setup.sh
source .venv/bin/activate        # Mac/Linux
source .venv/Scripts/activate    # Windows Git Bash
```

### Windows (PowerShell)
```powershell
cd Vibe_Code_Project_1
# First time only — allow local scripts to run:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\scripts\setup.ps1
.\.venv\Scripts\Activate.ps1
```

---

## Development Commands

```bash
python src/main.py       # Run locally
pytest                   # Run tests
ruff check src/ tests/   # Lint
black src/ tests/        # Format
mypy src/                # Type check
docker compose up --build  # Run with Docker
```

---

## CI/CD

| Trigger | Pipeline |
|---|---|
| Any push / PR to `main` or `develop` | Lint → Test → Docker build |
| Merge to `main` | + Push image to `ghcr.io/mwyatt9214-cmd/vibe-code-project-1` |

CI/CD only triggers when files inside `Vibe_Code_Project_1/` change,
so other projects in the repo won't interfere.

---

## Project Structure

```
Vibe_Code_Project_1/
├── src/
│   ├── main.py             # Entry point
│   ├── api/                # Route handlers / controllers
│   ├── models/             # Data models
│   ├── services/           # Business logic
│   └── utils/              # Shared helpers
├── tests/
│   ├── unit/
│   └── integration/
├── scripts/
│   ├── setup.sh            # Mac / Linux / Git Bash / WSL
│   └── setup.ps1           # Windows PowerShell
├── .github/workflows/
│   ├── ci.yml
│   └── cd.yml
├── .devcontainer/          # VS Code Dev Container
├── Dockerfile              # Multi-stage production image
├── docker-compose.yml      # App + Postgres + Redis
├── docker-compose.test.yml # Isolated test environment
├── pyproject.toml          # Tool config (pytest, black, ruff, mypy)
├── requirements.txt
├── requirements-dev.txt
└── .env.example            # Copy to .env and fill in secrets
```
