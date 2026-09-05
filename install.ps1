# ==============================================================================
# ARNES-IA-V5 Installer / Injector (PowerShell / Windows)
# ==============================================================================
# Inyecta el arnés esbelto V5 en el proyecto actual desde GitHub.
# Uso: irm https://raw.githubusercontent.com/jsmiragregori/ARNES-IA-V5/main/install.ps1 | iex
# ==============================================================================
$ErrorActionPreference = "Stop"

$RepoRaw = "https://raw.githubusercontent.com/jsmiragregori/ARNES-IA-V5/main"

Write-Host "🚀 [ARNES V5] Inyectando arnés agéntico en el proyecto actual..." -ForegroundColor Cyan

# 1. Crear directorios necesarios
New-Item -ItemType Directory -Force -Path "scripts", "templates\check-examples", "docs" | Out-Null

# 2. Descargar archivos de gobernanza
Write-Host "📥 Descargando AGENTS.md y CLAUDE.md..."
Invoke-WebRequest -Uri "$RepoRaw/AGENTS.md" -OutFile "AGENTS.md"
Invoke-WebRequest -Uri "$RepoRaw/CLAUDE.md" -OutFile "CLAUDE.md"

# 3. Descargar runners de verificación
Write-Host "📥 Descargando runners de Quality Gate..."
Invoke-WebRequest -Uri "$RepoRaw/scripts/check.sh" -OutFile "scripts\check.sh"
Invoke-WebRequest -Uri "$RepoRaw/scripts/check.ps1" -OutFile "scripts\check.ps1"

# 4. Descargar plantillas clave
Write-Host "📥 Descargando plantillas de diseño y especificación..."
Invoke-WebRequest -Uri "$RepoRaw/templates/DESIGN-TEMPLATE.md" -OutFile "templates\DESIGN-TEMPLATE.md"
Invoke-WebRequest -Uri "$RepoRaw/templates/SPEC-TEMPLATE.md" -OutFile "templates\SPEC-TEMPLATE.md"

# 5. Descargar ejemplos de check
Invoke-WebRequest -Uri "$RepoRaw/templates/check-examples/check-node.ps1" -OutFile "templates\check-examples\check-node.ps1"
Invoke-WebRequest -Uri "$RepoRaw/templates/check-examples/check-python.ps1" -OutFile "templates\check-examples\check-python.ps1"
Invoke-WebRequest -Uri "$RepoRaw/templates/check-examples/check-laravel.ps1" -OutFile "templates\check-examples\check-laravel.ps1"

Write-Host ""
Write-Host "✅ [ARNES V5] Arnés instalado con éxito." -ForegroundColor Green
Write-Host "👉 Siguientes pasos:"
Write-Host "   1. Coloca tu BRIEF.md y tu DESIGN.md en la raíz."
Write-Host "   2. Abre tu agente (Antigravity, Claude Code, Cursor, OpenCode)."
Write-Host "   3. ¡Empieza en modo UI-First!"
