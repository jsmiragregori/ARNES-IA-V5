#!/usr/bin/env bash
set -euo pipefail

echo "==> [1/4] Formato y Linting (Ruff)..."
ruff check .
ruff format --check .

echo "==> [2/4] Verificación de Tipos Estáticos (Mypy)..."
mypy .

echo "==> [3/4] Ejecutando Tests (Pytest)..."
pytest -q

echo "==> [4/4] Auditoría de Seguridad (Bandit / pip-audit)..."
bandit -q -r app/ || true
pip-audit || true

echo "✅ Quality Gate superado con éxito."
