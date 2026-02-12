# Arquitectura del Agente de Búsqueda Laboral con n8n

## 1. Diagrama Lógico del Flujo

```mermaid
graph TD
    A[Cron Trigger\n(Diario 09:00 AM)] --> B{Cargar Configuración}
    B --> C[Iterar Portales\n(SplitInBatches)]
    C -->|Portal 1: LinkedIn| D[Sub-Workflow: LinkedIn]
    C -->|Portal 2: Computrabajo| E[Sub-Workflow: Computrabajo]
    C -->|Portal N| F[Sub-Workflow: Generic/Other]
    
    D --> G[Normalizar Datos]
    E --> G
    F --> G
    
    G --> H{Deduplicación\n(Check DB Hash)}
    H -->|Ya existe| I[Ignorar / Update Fecha]
    H -->|Nuevo| J[Enriquecimiento / Scoring\n(Code o IA)]
    
    J --> K[Guardar en DB\n(PostgreSQL)]
    K --> L[Notificar Resultados\n(Resumen Diario)]
```

## 2. Componentes Principales

### A. Orquestador (Master Workflow)
Es el "jefe" de la operación. No hace scraping, solo gestiona.
- **Responsabilidades:**
  - Iniciar la ejecución (Cron).
  - Definir qué portales revisar hoy.
  - Recibir los resultados de los "workers" (sub-workflows).
  - Filtrar duplicados globales (una oferta puede estar en LinkedIn y ZonaJobs; el hash debe detectar esto si la URL varía pero el contenido es idéntico).
  - Guardar en Base de Datos.

### B. Workers (Sub-Workflows por Portal)
Cada portal es un mundo. Separarlos permite que si Computrabajo cambia su HTML, solo se rompe ese worker y no todo el sistema.
- **Entrada:** Keywords de búsqueda, Ubicación.
- **Proceso:** 
  - HTTP Request (GET search page).
  - HTML Extract (Extraer lista de items).
  - Loop interno (Paginar si es necesario).
  - Code Node (Limpieza inicial: quitar espacios, convertir fechas relativas a absolutas).
- **Salida:** JSON estandarizado (Array de ofertas).

### C. Base de Datos (PostgreSQL)
Centraliza la verdad.
- **Clave:** `hash_id`. Se genera combinando `MD5(Normalizar(Titulo) + Normalizar(Empresa))`. Esto evita guardar la misma oferta dos veces incluso si la URL cambia ligeramente.

## 3. Estrategia de Escalabilidad
- **Nuevos Portales:** Simplemente se crea un nuevo Sub-Workflow y se agrega a la lista de iteración en el Master.
- **Bloqueos:** Si un portal empieza a bloquear, se puede conectar ese Sub-Workflow específico a un servicio de Proxy o Scraping API (como ZenRows o ScrapingBee) sin tocar el resto de la lógica.
