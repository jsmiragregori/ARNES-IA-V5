# AGENTS.md — Reglas Universales del Arnés V5

Este archivo gobierna el comportamiento de cualquier agente de IA (Antigravity, Claude Code, Codex, Cursor) en este repositorio. Su objetivo es construir software sistemático y de alta calidad con el mínimo consumo de tokens y cero burocracia innecesaria.

---

## 1. Las 4 Reglas de Oro

### 1. Higiene Radical de Contexto (Context Diet)
- **Git es la bitácora:** No crees diarios de proceso manuales (`proceso/1..N.md`). El historial y las intenciones viven en los commits de Git y en las specs activas.
- **Foco estrecho:** Trabaja en una sola feature a la vez. No cargues en contexto archivos históricos irrelevantes.
- **Concisión:** Comunica lo que has hecho, los tests ejecutados y el resultado del gate. No justifiques con párrafos de relleno.

### 2. UI-First con `DESIGN.md` (Si el proyecto tiene interfaz)
- **El diseño no se inventa a ciegas:** Si existe un [DESIGN.md](DESIGN.md) en la raíz, es la autoridad estética única. Contiene los tokens (colores OKLCH, tipografía, espaciado, radios) y la *Creative North Star*.
- **Sin desvíos vanilla:** No construyas mockups en HTML/CSS plano desconectados. Monta las vistas **directamente en los componentes del stack final** (JSX/TSX, Blade, Jinja, Vue, etc.) usando datos mockeados.
- **Mapeo inmediato:** El primer paso en cualquier proyecto con UI es mapear los tokens de `DESIGN.md` al archivo de estilos global del proyecto (Tailwind `@theme`, CSS Variables, etc.).

### 3. Lógica guiada por EARS y TDD Quirúrgico
- **Especificaciones EARS:** Toda lógica o feature se define en un archivo único en `specs/<feature>.spec.md` usando la sintaxis formal EARS (Ubiquitous, Event, State, Unwanted, Optional).
- **TDD donde importa:** 
  - **OBLIGATORIO:** En lógica de negocio, cálculos, validaciones de esquema, transformaciones de datos, seguridad y endpoints de API. Escribe primero los tests basados en los requisitos EARS.
  - **OPCIONAL / LIGERO:** En maquetación puramente visual (la estética se valida en navegador, no con tests frágiles de DOM).

### 4. Ciberseguridad Defensiva (OWASP Top 10)
- **Inyecciones:** Prohibido concatenar parámetros en consultas de base de datos. Usa siempre ORM o queries parametrizadas.
- **Validación en frontera:** Todo dato externo (body, query params, headers) DEBE validarse contra un esquema estricto y tipado (Zod, Pydantic, FormRequest, etc.).
- **Anti-XSS:** Nunca renderices HTML sin escapar (`dangerouslySetInnerHTML`, `{!! !!}`, etc.) salvo sanitización explícita justificada.
- **Control de Acceso (IDOR):** Valida la autorización y propiedad del recurso en backend; nunca confíes únicamente en un ID enviado por el cliente.
- **Cero Secretos:** Prohibido hardcodear contraseñas, tokens o API keys. Usa siempre variables de entorno y documenta las variables requeridas en `.env.example`.

---

## 2. El Bucle de Trabajo en 3 Fases

Cada tarea sigue estrictamente este ciclo:

```
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│  1. ESPECIFICAR │ ───> │ 2. IMPLEMENTAR  │ ───> │  3. VERIFICAR   │
│  (EARS/Contrato)│      │  (Código+Tests) │      │ (scripts/check) │
└─────────────────┘      └─────────────────┘      └─────────────────┘
```

1. **Especificar:** Identifica o extrae los requisitos EARS y contratos de datos en `specs/<feature>.spec.md`.
2. **Implementar:** Escribe los tests de lógica (TDD), la implementación limpia y la interfaz con componentes reales.
3. **Verificar (Quality Gate):** Ejecuta `./scripts/check` (o el runner del proyecto).
   - **Regla dura:** Si el script devuelve un código de salida distinto de `0`, soluciona los errores antes de dar la tarea por completada o pedir revisión al usuario.

---

## 3. Comandos Estándar y Multiplataforma

- **Verificación completa (Quality Gate):**
  - En macOS / Linux / Git Bash / WSL: `./scripts/check.sh`
  - En Windows (PowerShell): `.\scripts\check.ps1`
  - O el comando nativo del ecosistema configurado en el proyecto (`npm run check`, `composer check`, etc.).
  - **Regla dura:** La salida debe ser código `0`. Si falla, corrige el error antes de avisar al usuario.
- **Portabilidad de código:** Todo path debe usar separadores o APIs del lenguaje (`path.join()`, `os.path.join()`, `DIRECTORY_SEPARATOR`), evitando hardcodear barras `/` o `\` exclusivas de un SO.
- **Entorno de desarrollo:** Consulta el README del proyecto (`npm run dev`, `php artisan serve`, `fastapi dev`, etc.).
