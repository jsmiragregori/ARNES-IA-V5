$ErrorActionPreference = "Stop"

Write-Host "==> [1/4] Formato y Linting (Ruff)..."
ruff check .
ruff format --check .

Write-Host "==> [2/4] Verificación de Tipos Estáticos (Mypy)..."
mypy .

Write-Host "==> [3/4] Ejecutando Tests (Pytest)..."
pytest -q

Write-Host "==> [4/4] Auditoría de Seguridad..."
bandit -q -r app/
pip-audit

Write-Host "✅ Quality Gate superado con éxito."
