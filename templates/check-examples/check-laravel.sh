#!/usr/bin/env bash
set -euo pipefail

echo "==> [1/4] Formato de código (Laravel Pint)..."
./vendor/bin/pint --test

echo "==> [2/4] Análisis estático de tipos (PHPStan / Larastan)..."
./vendor/bin/phpstan analyse --memory-limit=1G

echo "==> [3/4] Ejecutando Tests (Pest / PHPUnit)..."
./vendor/bin/pest

echo "==> [4/4] Auditoría de Seguridad de Dependencias (Composer)..."
composer audit

echo "✅ Quality Gate superado con éxito."
