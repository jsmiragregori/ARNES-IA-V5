#!/usr/bin/env bash
set -euo pipefail

echo "==> [1/4] Formato (gofmt)..."
test -z "$(gofmt -l .)"

echo "==> [2/4] Linting (golangci-lint)..."
golangci-lint run

echo "==> [3/4] Ejecutando Tests (go test)..."
go test -v -race ./...

echo "==> [4/4] Vulnerabilidades (govulncheck)..."
govulncheck ./...

echo "✅ Quality Gate superado con éxito."
