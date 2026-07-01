# 🏥 Sistema de Gestión de Triaje Digital para Centros de Salud

![Status](https://img.shields.io/badge/estado-en%20desarrollo-yellow)
![License](https://img.shields.io/badge/licencia-académica-blue)
![SQL Server](https://img.shields.io/badge/BD-SQL%20Server-CC2927)
![Java](https://img.shields.io/badge/backend-Java-orange)
![ODS](https://img.shields.io/badge/ODS-3%20Salud%20y%20Bienestar-green)

**Proyecto académico — Universidad Continental**
Asignatura: Diseño y Análisis de Software | NRC 28638 | Semestre 2026-10
Profesora: Mg. Rosario Delia Osorio Contreras

**Grupo 3:**
| Integrante | Rol en el proyecto |
|---|---|
| Carhuaz Barzola, Juan Abel | Arquitectura, patrones de diseño, base de datos |
| Huaraca Huaraca, Frank | Prototipo, seguridad, GitHub |
| Silva Crispín, Yanpol | Requisitos, metodología, documentación |

---

## 📋 Tabla de contenidos

- [Descripción](#-descripción)
- [Problema que resuelve](#-problema-que-resuelve)
- [Características principales](#-características-principales)
- [Arquitectura](#-arquitectura)
- [Patrones de diseño aplicados](#-patrones-de-diseño-aplicados)
- [Tecnologías utilizadas](#-tecnologías-utilizadas)
- [Estructura del repositorio](#-estructura-del-repositorio)
- [Instalación y ejecución](#-instalación-y-ejecución)
- [Seguridad](#-seguridad)
- [Metodología de trabajo](#-metodología-de-trabajo)
- [Documentación completa](#-documentación-completa)
- [Aporte al ODS 3](#-aporte-al-ods-3)
- [Licencia](#-licencia)

---

## 📖 Descripción

Sistema de gestión de triaje digital basado en **reglas clínicas parametrizadas**,
orientado a centros de salud públicos y privados del Perú (hospitales, postas
médicas, clínicas), alineado al **ODS 3: Salud y Bienestar**.

Permite registrar pacientes, capturar signos vitales, clasificar automáticamente
el nivel de urgencia (Grave / Moderado / Leve) mediante un motor de reglas
clínicas, y organizar la cola de atención priorizando siempre los casos más
críticos.

## ❗ Problema que resuelve

En muchos establecimientos de salud del Perú el triaje se realiza de forma
manual o con herramientas poco integradas, generando:

- Tiempos de espera prolongados
- Riesgo de subestimar la gravedad de pacientes críticos
- Falta de trazabilidad en la evaluación inicial
- Sobrecarga del personal de salud

## ✨ Características principales

- ✅ Clasificación automática de pacientes por nivel de urgencia
- ✅ Cola de atención reordenada en tiempo real por prioridad (RD07, RD08)
- ✅ Reglas clínicas configurables sin modificar el código fuente
- ✅ Control de acceso por roles (Enfermero / Médico / Administrador)
- ✅ Auditoría inmutable de cada cambio de estado o prioridad
- ✅ Soporte offline con sincronización diferida (modo sin conexión)

## 🏗️ Arquitectura

Arquitectura en 3 capas:

```
┌─────────────────────────────┐
│   Capa de Presentación      │  → Web / Móvil (Login, Registro, Cola)
├─────────────────────────────┤
│  Capa de Lógica de Negocio  │  → TriajeController, AuthController,
│                              │     MotorReglas (Strategy + Factory)
├─────────────────────────────┤
│   Capa de Acceso a Datos    │  → DatabaseConnection (Singleton)
└─────────────────────────────┘
              │
              ▼
      Microsoft SQL Server (db_triaje)
```

## 🎯 Patrones de diseño aplicados

| Patrón | Tipo | Problema que resuelve |
|---|---|---|
| **Singleton** | Creacional | Evita múltiples conexiones simultáneas a la BD desde distintas terminales |
| **Strategy** | Comportamiento | Reglas clínicas distintas según perfil (adulto / pediátrico / obstétrica) |
| **Factory** | Creacional | Selecciona automáticamente la estrategia correcta sin acoplar el controlador |

## 🛠️ Tecnologías utilizadas

| Categoría | Tecnología |
|---|---|
| Backend | Java |
| Base de datos | Microsoft SQL Server |
| Frontend | HTML / Figma (prototipo) |
| Metodología | SCRUM (Jira) |
| Modelado | UML, BPMN 2.0 |
| Control de versiones | Git / GitHub |
| Estándares | ISO/IEC/IEEE 29148:2018, ISO/IEC 25010:2011 |

## 📂 Estructura del repositorio

## 🚀 Instalación y ejecución

### Requisitos previos
- Microsoft SQL Server 2019 o superior
- JDK 11 o superior
- Driver `mssql-jdbc` (Maven o descarga manual)

### Pasos

```bash
# 1. Clonar el repositorio
git clone https://github.com/carhuaz/Proyecto-de-triaje-digital.git
cd Proyecto-de-triaje-digital

# 2. Crear el esquema de base de datos
sqlcmd -S localhost -i BaseDatos/SDTDS-2.sql

# 3. Configurar roles y permisos RBAC
sqlcmd -S localhost -i BaseDatos/Control-acceso-STD-2.0.sql

# 4. Configurar la variable de entorno con la contraseña de BD
export DB_PASSWORD="tu_password_real"

# 5. Compilar y ejecutar el backend (ejemplo con javac)
cd Prototipo/src
javac -d ../bin controllers/*.java factories/*.java models/*.java strategies/*.java
java -cp ../bin controllers.TriajeController
```

> ⚠️ Nunca subas tu contraseña real al repositorio. El archivo `.gitignore`
> ya excluye `config.properties` y `.env` por seguridad.

## 🔒 Seguridad

| Mecanismo | Implementación |
|---|---|
| Autenticación | Tokens JWT con expiración por turno |
| Contraseñas | BCrypt, factor de costo 12 |
| Control de acceso | RBAC nativo de SQL Server (roles + `GRANT`) |
| Comunicación | TLS/HTTPS entre capas |
| Auditoría | Tabla `HistorialTriaje` de solo inserción (inmutable, ni el administrador puede editarla o borrarla) |

## 🔄 Metodología de trabajo

Se utilizó **SCRUM**, con el backlog gestionado en Jira, organizado en 3 sprints:

| Sprint | Enfoque |
|---|---|
| Sprint 1 | Núcleo del sistema: login, registro de pacientes, registro clínico |
| Sprint 2 | Clasificación automática y cola de atención priorizada |
| Sprint 3 | Reportes, cierre de sesión y ajustes finales |

Ver detalle completo en [`Trazabilidad/jira.txt`](./Trazabilidad/jira.txt).

## 📚 Documentación completa

| Documento | Ubicación |
|---|---|
| Especificación de requisitos (ISO 29148) | `Documentacion/InformeParcial.pdf` |
| Evaluación de calidad (ISO 25010) | `Documentacion/Evaluacion_parcial.pdf` |
| Diagramas UML y presentación | `Modelos/` |

## 🌍 Aporte al ODS 3

Este proyecto contribuye al **Objetivo de Desarrollo Sostenible 3 (Salud y
Bienestar)** al automatizar y estandarizar la clasificación de pacientes,
reduciendo el sesgo humano en la priorización y garantizando que los casos
más graves reciban atención inmediata, independientemente del orden de
llegada.

## 📄 Licencia

Proyecto académico de uso educativo — Universidad Continental, 2026.
No distribuido para uso comercial ni clínico real sin validación
regulatoria previa por el MINSA.

---

<p align="center">Desarrollado con 💙 por el Grupo 3 — Diseño y Análisis de Software</p>
