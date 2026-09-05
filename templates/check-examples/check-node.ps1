$ErrorActionPreference = "Stop"

Write-Host "==> [1/4] Verificando tipos (TypeScript)..."
npx tsc --noEmit

Write-Host "==> [2/4] Ejecutando Linter..."
npm run lint --if-present

Write-Host "==> [3/4] Ejecutando Tests..."
npx vitest run --silent

Write-Host "==> [4/4] Auditoría de seguridad (Dependencias)..."
npm audit --audit-level=high

Write-Host "✅ Quality Gate superado con éxito."
