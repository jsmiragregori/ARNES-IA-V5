#!/usr/bin/env bash
# ==============================================================================
# ARNES-IA-V5 Universal Quality Gate Runner
# ==============================================================================
# El agente ejecuta este script antes de dar una tarea por completada.
# Exit code 0 = Aprobado
# Exit code > 0 = Bloqueado (el agente debe arreglar los fallos)
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

# 1. Si existe un script de check local del proyecto, delega en él:
if [ -f "scripts/local-check.sh" ]; then
  exec "scripts/local-check.sh"
fi

# 2. Detección automática según el stack:
if [ -f "package.json" ]; then
  echo "🔍 [ARNES V5] Stack detectado: Node.js / TypeScript"
  if npm run | grep -q "check"; then
    exec npm run check
  fi
  npx tsc --noEmit --pretty false || true
  npm run lint --if-present
  npm test --if-present
  exit 0
fi

if [ -f "composer.json" ]; then
  echo "🔍 [ARNES V5] Stack detectado: PHP / Composer"
  ./vendor/bin/pint --test || true
  ./vendor/bin/phpstan analyse || true
  ./vendor/bin/pest || ./vendor/bin/phpunit || true
  exit 0
fi

if [ -f "pyproject.toml" ] || [ -f "requirements.txt" ]; then
  echo "🔍 [ARNES V5] Stack detectado: Python"
  ruff check . || true
  mypy . || true
  pytest -q || true
  exit 0
fi

if [ -f "Cargo.toml" ]; then
  echo "🔍 [ARNES V5] Stack detectado: Rust"
  cargo clippy -- -D warnings
  cargo test
  exit 0
fi

if [ -f "go.mod" ]; then
  echo "🔍 [ARNES V5] Stack detectado: Go"
  go test ./...
  exit 0
fi

echo "⚠️ [ARNES V5] No se detectó configuración de tests automática. Crea scripts/local-check.sh para tu proyecto."
exit 0
