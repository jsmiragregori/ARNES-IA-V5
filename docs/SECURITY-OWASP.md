# Guía de Ciberseguridad Defensiva y OWASP en ARNES-IA-V5

Los agentes de IA tienden a elegir la solución sintácticamente más corta, descuidando a menudo la seguridad. Esta guía define los controles preventivos y los escaneos automatizados para garantizar código ciberseguro sin consumir tokens extra.

---

## 1. Los 6 Vectores Críticos (OWASP Top 10)

### 1. Inyecciones (SQL, NoSQL, Comandos)
* **Peligro:** El agente concatena variables del usuario en queries SQL o comandos del sistema.
* **Regla:** Uso 100% obligatorio de consultas preparadas (prepared statements), parámetros vinculados (`?` o `:param`) o métodos nativos del ORM. Prohibido `exec()`, `eval()` o `system()` con entradas no sanitizadas.

### 2. Control de Acceso Roto (IDOR / BOLA)
* **Peligro:** Un usuario modifica el ID en una URL (`/api/documents/45`) y accede al documento de otro cliente.
* **Regla:** Nunca consultes únicamente por el ID del recurso. La consulta siempre debe incluir la identidad autenticada:
  ```sql
  -- MAL
  SELECT * FROM invoices WHERE id = :id;
  -- BIEN
  SELECT * FROM invoices WHERE id = :id AND user_id = :auth_user_id;
  ```

### 3. Exposición de Secretos
* **Peligro:** El agente escribe claves de API, contraseñas de BD o certificados directamente en el código.
* **Regla:** Todos los secretos residen en `.env` (ignorado en `.gitignore`). El repositorio solo incluye `.env.example` con valores vacíos o de prueba.

### 4. Cross-Site Scripting (XSS)
* **Peligro:** Renderizado de contenido HTML sin escapar aportado por usuarios.
* **Regla:** 
  - En React: Prohibido `dangerouslySetInnerHTML` salvo sanitización probada con DOMPurify.
  - En Laravel / Blade: Usar siempre `{{ $var }}` (escapado), nunca `{!! $var !!}`.
  - En Python / Jinja: Usar siempre el escape por defecto, nunca el filtro `| safe` con datos externos.

### 5. Configuración de Sesiones y Cookies (OAuth / Auth)
* **Regla:** Las cookies de sesión o refresh tokens deben llevar siempre las banderas:
  - `HttpOnly`: Impide acceso vía JavaScript (protege contra XSS).
  - `Secure`: Solo se transmite por HTTPS.
  - `SameSite=Lax` (o `Strict`): Previene ataques CSRF.
  - **Nunca** almacenar tokens sensibles de sesión en `localStorage`.

### 6. Validación Estricta en Frontera
* **Regla:** Todo punto de entrada de datos (endpoints HTTP, webhooks, mensajes de colas) debe validarse con esquemas tipados antes de tocar la capa de negocio (Zod, Pydantic, FormRequests).

---

## 2. Herramientas SAST Automatizadas en `./scripts/check`

Para no gastar tokens pidiéndole al LLM que "audite", ejecutamos herramientas de análisis estático gratuitas en local:

### Semgrep (El escáner universal OWASP)
Semgrep funciona en segundos sobre casi cualquier lenguaje (JS, TS, Python, PHP, Go, Rust, Java):
```bash
# Ejecutar reglas de OWASP Top 10 en local:
semgrep --config p/owasp-top-ten .
```

### Auditorías de Dependencias (SCA)
Añade a tu script de check la herramienta correspondiente:
- **Node:** `npm audit --audit-level=high`
- **PHP:** `composer audit`
- **Python:** `pip-audit`
- **Rust:** `cargo audit`
- **Go:** `govulncheck ./...`
