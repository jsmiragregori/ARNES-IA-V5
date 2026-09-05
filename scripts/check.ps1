# ==============================================================================
# ARNES-IA-V5 Universal Quality Gate Runner (PowerShell / Windows)
# ==============================================================================
# El agente ejecuta este script antes de dar una tarea por completada en Windows.
# Exit code 0 = Aprobado
# Exit code > 0 = Bloqueado (el agente debe arreglar los fallos)
# ==============================================================================
$ErrorActionPreference = "Stop"

# 1. Si existe un script de check local del proyecto:
if (Test-Path "scripts\local-check.ps1") {
    Write-Host "🔍 [ARNES V5] Ejecutando scripts\local-check.ps1..."
    & "scripts\local-check.ps1"
    exit $LASTEXITCODE
}

# 2. Detección automática según el stack:
if (Test-Path "package.json") {
    Write-Host "🔍 [ARNES V5] Stack detectado: Node.js / TypeScript"
    $pkg = Get-Content "package.json" -Raw | ConvertFrom-Json
    if ($pkg.scripts.check) {
        npm run check
        exit $LASTEXITCODE
    }
    npx tsc --noEmit
    if ($pkg.scripts.lint) { npm run lint }
    if ($pkg.scripts.test) { npm test }
    exit 0
}

if (Test-Path "composer.json") {
    Write-Host "🔍 [ARNES V5] Stack detectado: PHP / Composer"
    if (Test-Path "vendor\bin\pint.bat") { .\vendor\bin\pint.bat --test }
    if (Test-Path "vendor\bin\phpstan.bat") { .\vendor\bin\phpstan.bat analyse }
    if (Test-Path "vendor\bin\pest.bat") { .\vendor\bin\pest.bat }
    elseif (Test-Path "vendor\bin\phpunit.bat") { .\vendor\bin\phpunit.bat }
    exit 0
}

if ((Test-Path "pyproject.toml") -or (Test-Path "requirements.txt")) {
    Write-Host "🔍 [ARNES V5] Stack detectado: Python"
    ruff check .
    mypy .
    pytest -q
    exit 0
}

if (Test-Path "Cargo.toml") {
    Write-Host "🔍 [ARNES V5] Stack detectado: Rust"
    cargo clippy -- -D warnings
    cargo test
    exit 0
}

if (Test-Path "go.mod") {
    Write-Host "🔍 [ARNES V5] Stack detectado: Go"
    go test ./...
    exit 0
}

Write-Host "⚠️ [ARNES V5] No se detectó configuración de tests automática. Crea scripts\local-check.ps1 para tu proyecto."
exit 0
