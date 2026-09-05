$ErrorActionPreference = "Stop"

Write-Host "==> [1/4] Formato de código (Laravel Pint)..."
.\vendor\bin\pint.bat --test

Write-Host "==> [2/4] Análisis estático de tipos (PHPStan / Larastan)..."
.\vendor\bin\phpstan.bat analyse --memory-limit=1G

Write-Host "==> [3/4] Ejecutando Tests (Pest / PHPUnit)..."
.\vendor\bin\pest.bat

Write-Host "==> [4/4] Auditoría de Seguridad de Dependencias (Composer)..."
composer audit

Write-Host "✅ Quality Gate superado con éxito."
