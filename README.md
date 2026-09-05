# ARNES-IA-V5: Arnés Esbelto para Programación Agéntica

Un arnés de ingeniería del software diseñado específicamente para trabajar con agentes de IA (Google Antigravity, Claude Code, OpenAI Codex, Cursor) de forma **sistemática, rápida y de alta calidad**, eliminando la burocracia, la parálisis por proceso y el agotamiento de tokens de versiones anteriores.

---

## 🎯 Por qué V5 (De la Burocracia a la Eficiencia)

| Dimensión | Enfoque Anterior (V3 / V4) | Arnés V5 (Esbelto) |
| :--- | :--- | :--- |
| **Flujo de Trabajo** | Ritual estricto de 34 pasos por feature. | **Bucle ágil de 3 fases:** Especificar → Implementar → Verificar. |
| **Especificación** | OpenSpec con 4 artefactos por cambio y validadores JSON. | **Archivo único EARS (`specs/<feature>.spec.md`)**, conciso y directo. |
| **Diseño / UI** | Mockup vanilla HTML/CSS desconectado + 15 renders ciegos. | **UI-First directo en el stack** basado en `DESIGN.md` con hot-reload local. |
| **TDD** | TDD dogmático aplicado incluso a layouts visuales. | **TDD quirúrgico** en lógica de negocio, schemas, APIs y casos de error. |
| **Contexto / Tokens** | 50.000–100.000 tokens por feature (bitácora `proceso/1..136`). | **< 15.000 tokens** (Git es la bitácora; `AGENTS.md` < 80 líneas). |
| **Tecnología** | Acoplado a Node.js y TypeScript. | **Políglota Universal:** Node, Python, PHP/Laravel, Go, Rust, etc. |
| **Agentes** | Fragmentado entre herramientas. | **Multi-Agente Universal:** `AGENTS.md` + shim `CLAUDE.md`. |

---

## 🏗️ Estructura del Repositorio

```text
ARNES-IA-V5/
├── AGENTS.md                  # El corazón del arnés: directrices universales (<80 líneas)
├── CLAUDE.md                  # Enlace universal para Claude Code
├── TUTORIAL.md                # Guía paso a paso: de Brief a App funcionando
├── README.md                  # Manifiesto y visión del arnés
├── scripts/
│   ├── check.sh               # Runner Quality Gate para macOS / Linux / Git Bash
│   └── check.ps1              # Runner Quality Gate nativo para Windows PowerShell
├── templates/
│   ├── DESIGN-TEMPLATE.md     # Plantilla de diseño (Tokens YAML + North Star)
│   ├── SPEC-TEMPLATE.md       # Plantilla de especificación EARS en archivo único
│   └── check-examples/        # Scripts de verificación por lenguaje (Node, Python, Laravel, Go, Rust)
└── docs/
    ├── UI-FIRST-WORKFLOW.md   # Guía paso a paso: de DESIGN.md a vistas en localhost
    ├── EARS-SPEC-GUIDE.md     # Guía sintáctica EARS y prompts de extracción
    └── SECURITY-OWASP.md      # Directrices de ciberseguridad defensiva y SAST local
```

---

## 🚀 Cómo Iniciar un Proyecto con ARNES-IA-V5 (en 60 segundos)

1. **Copia los archivos esenciales a tu nuevo proyecto:**
   - Copia `AGENTS.md` y `CLAUDE.md` a la raíz.
   - Copia `scripts/check.sh` y adáptalo con el ejemplo de tu lenguaje de `templates/check-examples/`.
2. **Si el proyecto tiene interfaz gráfica (UI-First):**
   - Copia `templates/DESIGN-TEMPLATE.md` como `DESIGN.md` en la raíz y ajusta tus tokens/colores o usa uno de tus `DESIGN.md` preferidos.
   - Pide al agente: *"Mapea DESIGN.md a nuestros estilos y levanta las vistas principales con datos mock"*.
   - Valida en `http://localhost:3000` o tu servidor local.
3. **Cuando definas la lógica funcional:**
   - Crea `specs/<feature>.spec.md` usando `templates/SPEC-TEMPLATE.md` (o pide al agente que extraiga las sentencias EARS de tu documentación/prompt).
   - El agente escribe los tests (TDD) para los requisitos EARS, implementa la solución y corre `./scripts/check.sh`.
4. **Listo para commit:**
   - Si `./scripts/check.sh` devuelve `0`, revisas el `git diff` y haces commit.
