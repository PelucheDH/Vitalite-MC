# Vitalite-MC
Trabajo de Titulación




🧩 1️⃣ Guardar y subir actualización en GitHub
💡 Pasos

🔹 1. Antes de comenzar un sprint

Asegúrate de estar en la rama de desarrollo:

git checkout dev


Trae los cambios más recientes por si otro colaborador subió algo:

git pull origin dev


Haz un último commit:

git add .
git commit -m "Sprint 1 completado - configuración inicial lista"


Sube los cambios a GitHub:

git push origin dev

## Flujo de trabajo con Git
- Rama principal: `main` (versión estable del sistema)
- Rama de desarrollo: `dev` (trabajo activo por sprint)
- Flujo básico:
  1. git checkout dev
  2. git add .
  3. git commit -m "HU/HT: descripción del avance"
  4. git push origin dev
  5. Al cerrar sprint → merge a `main`

## BACKEND ACTIVAR 
1. cd backend
2. node src/server.js

3. Ctrl + C (Fin)

## FRONTEND ACTIVAR
1. cd frontend
2. npx vite

3. Ctrl + C (Fin)
