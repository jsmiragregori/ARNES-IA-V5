# Guía de Flujo UI-First en ARNES-IA-V5

Esta guía explica cómo construir interfaces de usuario de alta calidad de forma rápida, directa y sin caer en la trampa de generar mockups vanilla intermedios que devoran tokens.

---

## 1. La Filosofía: "Direct-to-Stack"

En las versiones anteriores del arnés, se intentaba crear el diseño en un sandbox aislado (HTML/CSS vanilla), pasando por múltiples rondas de renders en imágenes y destilados, para luego tener que volver a picar todo el código dentro de un framework (Next.js, Laravel, etc.).

**En V5 eliminamos el intermediario:**
* El diseño se construye **directamente en el stack final de la aplicación** (componentes React, vistas Blade de Laravel, plantillas Jinja, etc.).
* El diseño se apoya en un documento previo de verdad: **`DESIGN.md`**.
* La verificación estética la hace el desarrollador mirando su pantalla en `localhost` con Hot Module Replacement (HMR). Cero coste de tokens para validar si un botón te gusta.

---

## 2. El Proceso en 3 Pasos

```
┌─────────────────────────┐      ┌─────────────────────────┐      ┌─────────────────────────┐
│  PASO 1: BOOTSTRAP      │ ───> │  PASO 2: VISTAS CON MOCK│ ───> │  PASO 3: CABLEADO CON   │
│  Mapear DESIGN.md a CSS │      │  Maquetar componentes   │      │  EARS y TDD en backend  │
└─────────────────────────┘      └─────────────────────────┘      └─────────────────────────┘
```

### Paso 1: El Bootstrap Visual (Inyección de Tokens)
1. Coloca tu archivo `DESIGN.md` en la raíz del proyecto.
2. Pídele al agente:
   > *"Lee `DESIGN.md` y configura las variables CSS / `@theme` de Tailwind en nuestro archivo de estilos principal. Configura también las tipografías indicadas."*
3. El agente genera la capa base de tokens:
   - En Tailwind v4: bloque `@theme` en `globals.css` o `app.css`.
   - En CSS estándar: `:root { --color-canvas: ...; --font-display: ...; }`.
   - En frameworks con Tailwind + shadcn/ui: ajusta las variables HSL/OKLCH del tema.

### Paso 2: Maquetación con Datos Simulados (Mock Data)
1. En lugar de crear la base de datos o APIs primero, el agente crea las vistas y páginas usando **props o archivos de mocks estáticos** (`mocks/data.ts` o similares).
2. El agente respeta estrictamente las directrices y componentes de `DESIGN.md`:
   - Utiliza la jerarquía de títulos definida (`display`, `h1`, `h2`).
   - Usa los colores semánticos (`canvas` para fondo, `surface` para tarjetas, `primary` para CTAs).
   - Respeta las reglas de no usar anti-patrones prohibidos en `DESIGN.md`.
3. Abres el navegador en tu máquina local (`http://localhost:3000` o `http://localhost:8000`).
4. **Validación interactiva:** Ajustas detalles con el agente en turnos rápidos:
   > *"La tarjeta de precios está demasiado pegada al hero. Aplica el espaciado `spacing.section-gap` de DESIGN.md."*

### Paso 3: Cablear la Funcionalidad (Backing Funcional)
Una vez que la interfaz está aprobada visualmente:
1. Extraes los requisitos funcionales con **EARS** en `specs/<feature>.spec.md`.
2. Escribes los tests de backend o endpoints (TDD).
3. Reemplazas los datos mock por las llamadas a base de datos, APIs o server actions.

---

## 3. Prompts Recomendados para el Agente

### Para arrancar el tema:
```text
Lee DESIGN.md. Mapea todos los tokens (colores, tipografía y radios) a nuestro sistema de estilos global. No crees vistas todavía; asegúrate de que el body use los estilos base (canvas e ink) y que las fuentes estén importadas correctamente.
```

### Para construir una pantalla UI-First:
```text
Construye la página de [Nombre de Página] siguiendo fielmente DESIGN.md. Utiliza datos mock en el propio componente para mostrar estados realistas (lista vacía, lista con 3 elementos y estado de carga). No implementes lógica de backend todavía.
```
