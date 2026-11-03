# UserMaster

Aplicación Flutter del Taller 2: UI y navegación con Clean Architecture y
autenticación simulada, sin backend.

## Descripción

UserMaster permite iniciar sesión, registrarse y recuperar contraseña mediante
flujos simulados con `Future.delayed`. Incluye un dashboard con elementos
recientes y un perfil de usuario con cierre de sesión.

## Objetivos

- Implementar los principios básicos de Clean Architecture.
- Centralizar la navegación en rutas nombradas.
- Reutilizar widgets y definir la paleta en `app_colors.dart`.
- Simular la autenticación con estados locales.
- Automatizar el despliegue web con GitHub Actions y GitHub Pages.

## Tech Stack

- Flutter 3.47 / Dart 3.13
- flutter_bloc (Cubit) + equatable
- Material 3
- GitHub Actions + GitHub Pages

## Estructura del proyecto

```text
lib/
├── core/          # Colores, temas, validadores y widgets reutilizables
├── data/          # Datasource local, modelos, mappers y repositorio
├── domain/        # Entidades, interfaz de repositorio y use cases
├── presentation/  # Cubit, páginas, widgets y rutas
├── app.dart
└── main.dart