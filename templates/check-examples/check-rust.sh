#!/usr/bin/env bash
set -euo pipefail

echo "==> [1/4] Formato (cargo fmt)..."
cargo fmt -- --check

echo "==> [2/4] Linting (clippy)..."
cargo clippy -- -D warnings

echo "==> [3/4] Ejecutando Tests..."
cargo test

echo "==> [4/4] Auditoría de Seguridad (cargo audit)..."
cargo audit

echo "✅ Quality Gate superado con éxito."
