# Guía del código del frontend

Para qué sirve cada parte importante y **qué tocar si te piden agregar, quitar o cambiar algo sin dañar la aplicación**.

Los archivos clave tienen al inicio un bloque **`GUÍA RÁPIDA`** con lo mismo, resumido. Búscalo en tu editor con `Ctrl + Shift + F` → `GUÍA RÁPIDA`.

> Casi todo cambio empieza en el backend. Su guía, con todas las recetas: [GUIA-DEL-CODIGO.md del backend](https://github.com/NIckys310/DroneMission-Pro-Backend/blob/main/GUIA-DEL-CODIGO.md).

---

## 1. Reglas de oro

1. **El frontend refleja al backend**: si cambia un DTO o un enum del backend, cambia aquí `src/types/index.ts` con los **mismos nombres de campo**.
2. **Los botones de una misión los decide el backend** (`availableActions`). Para mostrar u ocultar uno, la regla se cambia en el backend (`MissionAccessService`), no aquí.
3. **Todas las llamadas al servidor pasan por `src/api/`**: nunca uses `fetch` o `axios` sueltos en una pantalla.
4. **Sigue los errores de TypeScript**: `npm run build` marca en rojo cada pantalla afectada por un cambio.
5. **Comprueba al terminar**: `npm run build` y `npm test`.

---

## 2. Mapa: qué hace cada pieza

| Archivo | Para qué sirve |
|---|---|
| `src/api/client.ts` | Cliente HTTP único: agrega el token JWT y cierra la sesión si el servidor responde 401. |
| `src/api/endpoints.ts` | Una función por endpoint del backend (`missionApi`, `droneApi`…). |
| `src/auth/AuthContext.tsx` | Usuario conectado y `can("PERMISO")` para mostrar u ocultar cosas. |
| `src/auth/ProtectedRoute.tsx` | Protege rutas: sin sesión al login, sin permiso «Acceso prohibido». |
| `src/App.tsx` | Todas las rutas (páginas) de la aplicación. |
| `src/components/layout/AppLayout.tsx` | El menú lateral: la lista de opciones está en `useNavItems()`; cada una se ve solo con su permiso. |
| `src/hooks/useFetch.ts` | Carga datos; con un intervalo hace polling (telemetría cada 2 s). |
| `src/types/index.ts` | Tipos que reflejan los DTO del backend. |
| `src/utils/labels.ts` | Texto en español de cada valor de los enums. |
| `src/pages/<módulo>/` | Una carpeta por módulo; los formularios son arreglos de campos (`missionForm.ts`, `droneForm.ts`). |
| `src/pages/missions/MissionDetailPage.tsx` | Detalle de misión y sus botones de acción. |
| `src/pages/missions/TelemetryPanel.tsx` | Mapa, indicadores y gráfica del vuelo. |

---

## 3. «El profe me pide…» → qué tocar

| Pedido | Pasos en el frontend |
|---|---|
| **Un campo nuevo en un formulario** | Después de agregarlo al backend: 1) Campo en la interface de `types/index.ts` 2) Una línea en el arreglo del formulario (`missionForm.ts`, `droneForm.ts`…). El formulario genérico lo dibuja y lo valida solo. 3) Si debe verse en la tabla, una columna en la página del módulo. |
| **Cambiar un límite del formulario** (ej. altitud máxima) | El `min` / `max` del campo en su `*Form.ts`, igual que la regla del backend. |
| **Un valor nuevo de un enum** (ej. tipo de misión `RESCATE`) | Agrégalo al tipo en `types/index.ts` y su etiqueta en `utils/labels.ts`. |
| **Una página nueva** | 1) Componente en `src/pages/` 2) Su `<Route>` en `App.tsx`, dentro del `ProtectedRoute` con el permiso que corresponda 3) Su opción en `useNavItems()` de `AppLayout.tsx`, con su permiso. |
| **Un botón de acción nuevo en la misión** | Después de crearlo en el backend: función en `api/endpoints.ts` y botón en `MissionDetailPage.tsx`, visible solo si `has('ACCION')`. |
| **Quitar una página** | Borra su `<Route>`, su enlace del menú y su carpeta en `pages/`. |
| **Quitar un campo** | El camino inverso: el formulario, el tipo y la tabla. `npm run build` marca lo que falte. |
| **Cambiar la frecuencia de la telemetría** | El `2000` (milisegundos) en `TelemetryPanel.tsx`. |
| **Mostrar algo solo a un rol** | `const { can } = useAuth();` y `{can('PERMISO') && …}`. |

---

## 4. Cómo comprobar que no dañaste nada

```bash
npm run build   # revisa los tipos de TypeScript y genera dist/
npm test        # 15 pruebas (Vitest)
npm run dev     # http://localhost:5173 (con el backend en :8080)
```
