---
name: Nombre del Producto o Sistema
description: Breve descripción de la audiencia, tono y objetivo visual.
colors:
  canvas: "#FAF9F6"           # Fondo principal cálido/limpio (nunca #FFFFFF puro si se busca calidez)
  ink: "#1C1917"              # Texto principal (nunca #000000 puro, usar neutral profundo)
  primary: "oklch(65% 0.20 260)" # Color de acento principal (acciones, marca)
  primary-hover: "oklch(58% 0.22 260)"
  accent-subtle: "oklch(94% 0.04 260)" # Fondos sutiles de acento
  surface: "#FFFFFF"          # Fondo de tarjetas y contenedores
  border: "oklch(90% 0.01 90)" # Bordes sutiles
  # Pares semánticos de estado
  success: "oklch(72% 0.16 150)"
  warning: "oklch(78% 0.15 75)"
  error: "oklch(65% 0.22 25)"
typography:
  display:
    fontFamily: "Outfit, Playfair Display, sans-serif"
    fontSize: "clamp(2rem, 5vw, 3.75rem)"
    fontWeight: 600
    lineHeight: 1.1
    letterSpacing: "-0.02em"
  h1:
    fontFamily: "Outfit, sans-serif"
    fontSize: "clamp(1.75rem, 3.5vw, 2.5rem)"
    fontWeight: 600
    lineHeight: 1.2
    letterSpacing: "-0.015em"
  h2:
    fontFamily: "Outfit, sans-serif"
    fontSize: "clamp(1.35rem, 2.5vw, 1.75rem)"
    fontWeight: 600
    lineHeight: 1.25
  body:
    fontFamily: "Plus Jakarta Sans, Inter, sans-serif"
    fontSize: "1rem"
    fontWeight: 400
    lineHeight: 1.6
  label:
    fontFamily: "Plus Jakarta Sans, Inter, sans-serif"
    fontSize: "0.75rem"
    fontWeight: 600
    letterSpacing: "0.05em"
rounded:
  sm: "6px"
  md: "10px"
  lg: "16px"
  full: "9999px"
spacing:
  section-gap: "clamp(4rem, 8vw, 7rem)"
  container-max: "1200px"
---

# Design System: [Nombre del Producto]

## 1. Creative North Star (Brújula Creativa)
Describe en 1 o 2 párrafos la sensación que debe transmitir el producto.
*Ejemplo:* "Un espacio de consultoría silencioso, sobrio y riguroso. Menos pirotecnia de startup y más sensación de informe auditado de alta precisión. Tipografía con autoridad y un uso quirúrgico del color de acento."

## 2. Lo que queda EXPLÍCITAMENTE RECHAZADO (Anti-patrones)
- **NO usar** gradientes llamativos genéricos de moda ("purple haze").
- **NO usar** negro puro (`#000000`) sobre blanco puro (`#FFFFFF`).
- **NO usar** sombras gigantescas o efectos de cristal (*glassmorphism*) salvo justificación.
- **NO usar** animaciones que distraigan o retrasen la lectura del contenido.

## 3. Estrategia de Color y Contraste
- **Canvas vs. Surface:** El fondo general usa `{colors.canvas}`, mientras que las tarjetas usan `{colors.surface}` con un borde sutil `{colors.border}` para dar profundidad sin depender de sombras pesadas.
- **Acento Primario:** Reservado exclusivamente para la llamada a la acción (CTA) principal y el estado activo.

## 4. Tipografía y Jerarquía
- Títulos principales usan la fuente `display` con `letterSpacing` negativo sutil para condensar el titular.
- El cuerpo de texto usa `{typography.body}` con una altura de línea holgada (`1.6`) para garantizar máxima legibilidad.

## 5. Reglas de Componentes
- **Botón Primario:** Fondo `{colors.primary}`, texto legible con contraste WCAG AAA, bordes `{rounded.md}`, padding generoso.
- **Formularios:** Inputs con fondo `{colors.surface}`, borde sutil y un anillo de foco visible usando `{colors.primary}` en estado activo.
