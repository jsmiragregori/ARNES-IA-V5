# Spec: [Nombre de la Feature o Módulo]

## 1. Contexto y Objetivo
*3 a 5 líneas describiendo qué problema resuelve esta feature y qué usuario se beneficia.*

---

## 2. Requisitos EARS (Easy Approach to Requirements Syntax)

> Cada requisito debe utilizar uno de los 5 patrones EARS. No uses prosa ambigua.

### Ubiquitous (Comportamiento continuo o invariante)
- **REQ-U1:** El sistema DEBERÁ registrar en auditoría la dirección IP y el timestamp en cada intento de autenticación.

### Event-driven (Disparado por una acción)
- **REQ-E1:** CUANDO el usuario envíe el formulario con todos los campos válidos, el sistema DEBERÁ persistir la entidad y devolver código HTTP 201.
- **REQ-E2:** CUANDO se confirme la suscripción, el sistema DEBERÁ despachar el evento `SubscriptionActivated` a la cola de eventos.

### State-driven (Activo mientras dure un estado)
- **REQ-S1:** MIENTRAS la pasarela de pago esté procesando la transacción, el sistema DEBERÁ bloquear la edición del carrito.

### Unwanted Behavior / Error (Manejo de errores y límites)
- **REQ-W1:** SI el payload supera los 2MB, ENTONCES el sistema DEBERÁ rechazar la petición con error 413 Payload Too Large.
- **REQ-W2:** SI el usuario no tiene permisos de edición sobre el recurso, ENTONCES el sistema DEBERÁ responder 403 Forbidden y no revelar metadatos del recurso.

### Optional Feature (Condicional a configuración)
- **REQ-O1:** DONDE la variable `ENABLE_AI_SUMMARY` esté activa, el sistema DEBERÁ generar un resumen automático al guardar el documento.

---

## 3. Contratos de Datos y Tipos

Define los esquemas de entrada/salida (TypeScript/Zod, Pydantic, DTO de PHP, etc.):

```ts
// Ejemplo de contrato
export interface CreateItemInput {
  title: string;
  amount: number;
  tags?: string[];
}

export interface ItemResponse {
  id: string;
  title: string;
  createdAt: string;
}
```

---

## 4. Restricciones de Seguridad (OWASP)
- [ ] Validación estricta de todos los campos de entrada en la frontera.
- [ ] Verificación de autorización en backend (evitar IDOR).
- [ ] Sanitización y escape de datos en cualquier salida hacia el cliente.

---

## 5. Checklist de Tareas Técnicas
- [ ] 1. Tests unitarios para validación de datos (cubriendo REQ-W1, REQ-W2)
- [ ] 2. Implementación de la lógica de dominio / servicio
- [ ] 3. Endpoint / Controlador / Acción de interfaz
- [ ] 4. Tests de integración de flujo completo (cubriendo REQ-E1)
- [ ] 5. Verificación ejecutando `./scripts/check` (Pass = Exit 0)
