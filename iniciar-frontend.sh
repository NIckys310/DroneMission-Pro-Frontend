#!/usr/bin/env bash
# Inicia el frontend de DroneMission Pro en http://localhost:5173 (requiere el backend en :8080)
cd "$(dirname "$0")"
[ -d node_modules ] || npm install
npm run dev
