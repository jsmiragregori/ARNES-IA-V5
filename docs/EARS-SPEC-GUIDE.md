# Guía de Especificación EARS (Easy Approach to Requirements Syntax)

EARS es un estándar de especificación basado en plantillas sencillas de lenguaje natural. Desarrollado originalmente en Rolls-Royce para sistemas críticos, es el formato perfecto para programar con agentes de IA porque elimina la ambigüedad, ahorra tokens y se traduce de forma natural en casos de prueba (TDD).

---

## 1. Los 5 Patrones EARS

| Patrón | Estructura | Cuándo se usa |
| :--- | :--- | :--- |
| **Ubiquitous** | *El sistema DEBERÁ [acción]* | Comportamientos que siempre están activos (invariantes, seguridad global). |
| **Event-driven** | *CUANDO [evento disparador], el sistema DEBERÁ [acción]* | Acciones disparadas por el usuario, eventos externos o webhooks. |
| **State-driven** | *MIENTRAS [estado], el sistema DEBERÁ [acción]* | Comportamientos condicionados a que el sistema esté en un estado específico. |
| **Unwanted Behavior** | *SI [error / caso límite], ENTONCES el sistema DEBERÁ [acción]* | Gestión de errores, validaciones fallidas, caídas de red o ataques. |
| **Optional Feature** | *DONDE [característica activa], el sistema DEBERÁ [acción]* | Funcionalidades activables por flags, roles de usuario o tiers. |

---

## 2. Ejemplos Reales de Software

### Ejemplo A: Autenticación y Cuentas
* **Ubiquitous:** El sistema DEBERÁ hashear todas las contraseñas con Argon2id antes de persistirlas.
* **Event-driven:** CUANDO el usuario confirme su email haciendo clic en el enlace, el sistema DEBERÁ marcar la cuenta como verificada y redirigir al dashboard.
* **State-driven:** MIENTRAS la cuenta esté en estado "bloqueada", el sistema DEBERÁ rechazar cualquier intento de login con error 403.
* **Unwanted:** SI el usuario supera 5 intentos fallidos de login en 10 minutos, ENTONCES el sistema DEBERÁ bloquear la IP durante 15 minutos.
* **Optional:** DONDE el usuario tenga activado 2FA, el sistema DEBERÁ solicitar el token TOTP antes de emitir la cookie de sesión.

---

## 3. Cómo Mapear EARS a Tests Automatizados (TDD)

Cada sentencia EARS es la especificación directa de un test:

```typescript
// Requisito: CUANDO el usuario envíe un email válido, el sistema DEBERÁ enviar el código de acceso.
it('when user submits a valid email, sends access code', async () => { ... });

// Requisito: SI el email no tiene formato válido, ENTONCES el sistema DEBERÁ responder 422.
it('if email format is invalid, returns 422', async () => { ... });

// Requisito: MIENTRAS la cuenta esté bloqueada, el sistema DEBERÁ rechazar el login.
it('while account is locked, rejects login with 403', async () => { ... });
```

---

## 4. Prompt para Extraer EARS desde Documentos o Conversaciones

Copia este prompt y dáselo al agente para convertir cualquier texto desestructurado en una spec EARS limpia:

```text
Actúa como analista de requisitos senior. Lee el siguiente documento / transcripción y extrae todos los requisitos del sistema formateados estrictamente con la sintaxis EARS:
- Ubiquitous: El sistema DEBERÁ...
- Event-driven: CUANDO [evento], el sistema DEBERÁ...
- State-driven: MIENTRAS [estado], el sistema DEBERÁ...
- Unwanted: SI [error/caso límite], ENTONCES el sistema DEBERÁ...
- Optional: DONDE [condición], el sistema DEBERÁ...

Organízalos en un único archivo specs/<feature>.spec.md siguiendo nuestra plantilla SPEC-TEMPLATE.md. No agregues explicaciones redundantes.
```
