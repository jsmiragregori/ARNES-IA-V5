# Tutorial: Cómo Iniciar una Nueva Aplicación con ARNES-IA-V5

Esta guía paso a paso te muestra exactamente cómo arrancar un proyecto desde cero a partir de un documento de **brief**, utilizando el arnés esbelto V5 alojado en GitHub.

---

## 📋 Escenario de Partida
1. Tienes un **documento con el brief** de tu aplicación (ideas, público objetivo, casos de uso).
2. Aún no has escrito ninguna línea de código.
3. Dispones del repositorio **`ARNES-IA-V5`** en GitHub como plantilla de referencia.

---

## 🛠️ Fase 0: Inicialización del Proyecto (2 minutos)

### 1. Inicializa tu proyecto en el stack que prefieras
Crea la carpeta de tu nuevo proyecto con el stack elegido (Next.js, Laravel, FastAPI, Vite, etc.):

```bash
# Opción A (Next.js / TypeScript):
npx create-next-app@latest mi-app
cd mi-app

# Opción B (Laravel / PHP):
composer create-project laravel/laravel mi-app
cd mi-app

# Opción C (Python / FastAPI):
mkdir mi-app && cd mi-app && git init
```

### 2. Copia los archivos base del arnés desde GitHub
Solo necesitas incorporar **3 elementos** del repositorio `ARNES-IA-V5`:
1. **`AGENTS.md`** → Cópialo en la raíz de tu proyecto.
2. **`CLAUDE.md`** → Cópialo en la raíz de tu proyecto.
3. **`scripts/check.sh`** y/o **`scripts/check.ps1`** → Cópialos en la carpeta `scripts/` y adáptalos con la receta de tu lenguaje de `templates/check-examples/`.

### 3. Deposita tus dos documentos clave
* Guarda tu brief como **`BRIEF.md`** en la raíz (o en `input/brief.md`).
* Copia tu sistema de diseño preferido como **`DESIGN.md`** en la raíz (puedes usar `templates/DESIGN-TEMPLATE.md` como base).

---

## 🚀 Fase 1: Del Brief a la Hoja de Ruta EARS (3 minutos)

Abre tu agente de IA (Antigravity, Claude Code, Cursor o Codex) en la raíz del proyecto y dale este prompt:

> 💬 **Prompt 1 (Ingesta del Brief):**
> ```text
> Lee BRIEF.md y AGENTS.md.
> 1. Extrae en specs/roadmap.md una lista ordenada de las 4-5 features principales de la aplicación.
> 2. Para la primera feature de interfaz, genera specs/01-vistas-principales.spec.md definiendo los requisitos clave con sintaxis EARS.
> No implementes código todavía.
> ```

**Qué consigues:** Una hoja de ruta clara y una especificación precisa en menos de 1.000 tokens, sin burocracia ni artefactos vacíos.

---

## 🎨 Fase 2: UI-First "Direct-to-Stack" (15-20 minutos)

No creamos mockups vanilla en HTML plano ni esperamos rondas de renders en imágenes. La interfaz se maqueta directamente en los componentes reales de tu stack.

### 1. Inyección de Tokens de Diseño
> 💬 **Prompt 2 (Bootstrap Estético):**
> ```text
> Lee DESIGN.md. Mapea todos los tokens (colores OKLCH, tipografías, espaciados y radios) al archivo de estilos global del proyecto (Tailwind @theme o CSS Variables). Importa las fuentes necesarias y aplica los estilos base al body.
> ```

### 2. Maquetación con Datos Simulados (Mock Data)
> 💬 **Prompt 3 (Componentes y Pantallas con Mock):**
> ```text
> Siguiendo las pantallas descritas en BRIEF.md y la dirección visual de DESIGN.md, maqueta las páginas y componentes principales directamente en nuestro framework. Usa datos simulados (mock data) tipados para mostrar estados realistas (vacío, con datos, loading). No conectes bases de datos ni lógica de backend aún.
> ```

### 3. Validación Visual Humana (Instantánea y Gratis)
* Abre tu navegador en `http://localhost:3000` (o el puerto local de tu servidor).
* Ves la aplicación real con **Hot-Reload**.
* Si un espaciado o color necesita un retoque, das instrucciones quirúrgicas directas:
  > *"Aumenta el padding vertical del hero y usa el color primary de DESIGN.md para el botón de acción."*

---

## ⚙️ Fase 3: Cableado Funcional con EARS y TDD (Por Features)

Con la interfaz ya maquetada y aprobada visualmente, la lógica funcional es evidente. Para cada feature del roadmap:

### 1. Redactar la Spec EARS
> 💬 **Prompt 4 (Especificación EARS):**
> ```text
> Vamos a implementar la feature [X, ej: Autenticación y creación de sesiones]. Redacta specs/02-auth.spec.md con los requisitos EARS (casos normales, límites y casos de error 'SI..., ENTONCES...') y los esquemas tipados de datos.
> ```

### 2. TDD Quirúrgico e Implementación
> 💬 **Prompt 5 (TDD + Código):**
> ```text
> Implementa la feature de specs/02-auth.spec.md. Escribe primero los tests que cubran los requisitos EARS de validación y seguridad. Luego implementa la lógica conectando con la base de datos/API. Al terminar, ejecuta ./scripts/check.sh (o .\scripts\check.ps1 en Windows) y asegúrate de que pase con exit code 0.
> ```

### 3. Quality Gate y Commit
* El agente ejecuta el script de check (linter, types, tests y auditoría de seguridad).
* Cuando el resultado sea código `0`, haz commit en Git:
  ```bash
  git add .
  git commit -m "feat(auth): implement user authentication with EARS specs and tests"
  ```

---

## 🧠 Higiene de Contexto (Context Diet)

Para evitar que los tokens se agoten y el modelo pierda rendimiento:
* **Una sesión por feature:** Al terminar una feature y hacer commit, **reinicia el chat o abre una sesión fresca**.
* En la nueva sesión, el prompt de arranque solo necesita ser:
  > *"Retoma el proyecto leyendo AGENTS.md y specs/roadmap.md. Vamos a abordar la siguiente feature pendiente: specs/03-dashboard.spec.md."*
* **Git es la bitácora:** No crees diarios manuales de proceso en markdown; la historia del proyecto vive en los commits de Git.
