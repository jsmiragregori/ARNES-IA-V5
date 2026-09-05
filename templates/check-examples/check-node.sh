#!/usr/bin/env bash
set -euo pipefail

echo "==> [1/4] Verificando tipos (TypeScript)..."
npx tsc --noEmit

echo "==> [2/4] Ejecutando Linter..."
npm run lint --if-present

echo "==> [3/4] Ejecutando Tests..."
npx vitest run --silent

echo "==> [4/4] Auditoría de seguridad (Dependencias)..."
npm audit --audit-level=high

echo "✅ Quality Gate superado con éxito."
