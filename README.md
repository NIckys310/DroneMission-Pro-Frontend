# DroneMission Pro — Frontend

Interfaz web de **DroneMission Pro**, el sistema de gestión de operaciones y misiones con drones del proyecto de *Diseño de Software*.

**React 18 + TypeScript + Vite + Material UI.**

| | |
|---|---|
| 🌐 App en línea | https://dronemission-pro.onrender.com |
| ⚙️ Backend (API REST) | https://github.com/NIckys310/DroneMission-Pro-Backend |
| 📦 Proyecto completo (monorepo original) | https://github.com/NIckys310/DroneMission-Pro |
| 📚 Documentación, diagramas y exposición | En el repositorio del backend: `docs/` y `exposicion/` |

---

## Qué hace

Es una aplicación de una sola página (SPA) que consume la API REST del backend:

- Login con JWT, registro con aprobación y 5 roles (administrador, operador, piloto, técnico y cliente).
- Dashboard con indicadores y gráficas.
- Drones, pilotos, clientes, usuarios, roles y auditoría.
- Misiones con su ciclo de vida: crear, enviar, asignar drone y piloto, chequeo prevuelo, vuelo, pausa y cierre.
- Telemetría en vivo del drone virtual (se consulta cada 2 segundos mientras la misión vuela).
- Incidentes, evidencias, mantenimiento y reportes PDF.
- Simulador 3D de vuelo (Three.js) e instalación como aplicación (PWA).

## Requisitos

- **Node.js 18 o superior** (versión LTS).
- El **backend** corriendo en `http://localhost:8080` (ver su repositorio).

## Cómo ejecutarlo

**Windows:** doble clic en `iniciar-frontend.bat`. **Linux / Mac:** `./iniciar-frontend.sh`.

O manualmente:

```bash
npm install       # solo la primera vez
npm run dev       # http://localhost:5173 (redirige /api al backend en :8080)
npm run build     # verifica tipos y genera dist/
npm test          # 15 pruebas (Vitest)
```

Si el backend corre en otra dirección:

```bash
VITE_BACKEND_URL=http://otra-direccion:8080 npm run dev
```

En desarrollo, Vite redirige `/api` y `/demo` al backend (`vite.config.ts`), así no hay problemas de CORS.

### Usuarios de prueba (solo en local)

Con el backend en local (`APP_DEMO_USERS=true`, por defecto) existen estos usuarios. La contraseña de todos es `Demo2026!` y solo sirve para la demostración:

| Rol | Correo |
|---|---|
| Administrador | admin@dronemission.local |
| Operador | operador@dronemission.local |
| Piloto | piloto@dronemission.local |
| Técnico | tecnico@dronemission.local |
| Cliente | cliente@dronemission.local |

## Estructura

| Carpeta | Contenido |
|---|---|
| `src/api` | `client.ts` (Axios + token JWT + errores) y `endpoints.ts` (todos los endpoints del backend) |
| `src/auth` | `AuthContext` (sesión y permisos) y `ProtectedRoute` |
| `src/components` | Layout, formulario genérico `EntityFormDialog`, chips de estado, batería, mapa de vuelo… |
| `src/hooks` | `useFetch` (carga de datos y polling) y `useNotify` |
| `src/pages` | Una carpeta por módulo (drones, pilotos, misiones…); `simulator/` tiene el motor y la escena 3D |
| `src/types` | Tipos que reflejan los DTO del backend |
| `src/utils` | Etiquetas en español, formatos y validaciones |

Para agregar un campo a un formulario basta con añadir una línea al arreglo de campos de la página (por ejemplo, `pages/drones/droneForm.ts`).

## Cómo se conecta con el backend

- **Un solo cliente HTTP** (`src/api/client.ts`): agrega `Authorization: Bearer <token>` a cada petición y, si el backend responde 401, cierra la sesión y vuelve al login.
- **Rutas protegidas** (`src/auth/ProtectedRoute.tsx`): sin sesión redirige al login; sin el permiso pedido muestra «Acceso prohibido».
- **Los botones los decide el backend**: cada misión trae `availableActions` y la pantalla solo muestra esas acciones.

## Docker (opcional)

`Dockerfile` compila la app y la sirve con Nginx (`nginx.conf`), que reenvía `/api` a un contenedor llamado `backend` en el puerto 8080.

## Tecnologías

React 18 · TypeScript · Vite · React Router · Material UI · Recharts · Axios · Day.js · Three.js · Vitest
