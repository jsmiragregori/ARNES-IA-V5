#!/usr/bin/env bash
# ==============================================================================
# ARNES-IA-V5 Installer / Injector
# ==============================================================================
# Inyecta el arnés esbelto V5 en el proyecto actual desde GitHub.
# Uso: curl -fsSL https://raw.githubusercontent.com/jsmiragregori/ARNES-IA-V5/main/install.sh | bash
# ==============================================================================
set -euo pipefail

REPO_RAW="https://raw.githubusercontent.com/jsmiragregori/ARNES-IA-V5/main"

echo "🚀 [ARNES V5] Inyectando arnés agéntico en el proyecto actual..."

# 1. Crear directorios necesarios
mkdir -p scripts templates/check-examples docs

# 2. Descargar archivos de gobernanza
echo "📥 Descargando AGENTS.md y CLAUDE.md..."
curl -fsSL "${REPO_RAW}/AGENTS.md" -o AGENTS.md
curl -fsSL "${REPO_RAW}/CLAUDE.md" -o CLAUDE.md

# 3. Descargar runners de verificación
echo "📥 Descargando runners de Quality Gate..."
curl -fsSL "${REPO_RAW}/scripts/check.sh" -o scripts/check.sh
curl -fsSL "${REPO_RAW}/scripts/check.ps1" -o scripts/check.ps1
chmod +x scripts/check.sh

# 4. Descargar plantillas clave
echo "📥 Descargando plantillas de diseño y especificación..."
curl -fsSL "${REPO_RAW}/templates/DESIGN-TEMPLATE.md" -o templates/DESIGN-TEMPLATE.md
curl -fsSL "${REPO_RAW}/templates/SPEC-TEMPLATE.md" -o templates/SPEC-TEMPLATE.md

# 5. Descargar ejemplos de check
curl -fsSL "${REPO_RAW}/templates/check-examples/check-node.sh" -o templates/check-examples/check-node.sh
curl -fsSL "${REPO_RAW}/templates/check-examples/check-python.sh" -o templates/check-examples/check-python.sh
curl -fsSL "${REPO_RAW}/templates/check-examples/check-laravel.sh" -o templates/check-examples/check-laravel.sh
curl -fsSL "${REPO_RAW}/templates/check-examples/check-go.sh" -o templates/check-examples/check-go.sh
curl -fsSL "${REPO_RAW}/templates/check-examples/check-rust.sh" -o templates/check-examples/check-rust.sh
curl -fsSL "${REPO_RAW}/templates/check-examples/check-node.ps1" -o templates/check-examples/check-node.ps1
curl -fsSL "${REPO_RAW}/templates/check-examples/check-python.ps1" -o templates/check-examples/check-python.ps1
curl -fsSL "${REPO_RAW}/templates/check-examples/check-laravel.ps1" -o templates/check-examples/check-laravel.ps1
chmod +x templates/check-examples/*.sh 2>/dev/null || true

echo ""
echo "✅ [ARNES V5] Arnés instalado con éxito en $(pwd)."
echo "👉 Siguientes pasos:"
echo "   1. Coloca tu BRIEF.md y tu DESIGN.md en la raíz."
echo "   2. Abre tu agente (Antigravity, Claude Code, Cursor, OpenCode)."
echo "   3. ¡Empieza en modo UI-First!"
