# Agente de Búsqueda Laboral con n8n

¡Bienvenido! Este proyecto contiene todo lo necesario para tu agente de automatización.

## 🚀 Cómo Iniciar

1.  **Iniciar n8n:**
    Abre una terminal y ejecuta:
    ```bash
    n8n start
    ```
    O ve a http://localhost:5678 si ya se abrió.

2.  **Importar los Workflows:**
    *   En n8n, ve a `Workflows` -> `Import from File`.
    *   Selecciona los archivos en la carpeta `workflows/`:
        *   `01_Master_Orchestrator.json`
        *   `02_Portal_Computrabajo.json`

3.  **Configurar Base de Datos:**
    *   El flujo actual espera una base de datos PostgreSQL.
    *   Si tienes Postgres, ejecuta el script en `database/schema.sql`.
    *   **¿No tienes Postgres?** Puedes cambiar el nodo "Guardar en Postgres" por un nodo de **Google Sheets** o **Airtable** para empezar rápido.

## ☁️ Despliegue en la Nube (Render)

Este proyecto está preparado para ser desplegado en Render usando el archivo `render.yaml`.

### Pasos para desplegar:

1.  **Sube este código a tu repositorio de GitHub:**
    ```bash
    git add .
    git commit -m "Preparado para Render"
    git push origin master
    ```

2.  **Crea un nuevo Blueprint en Render:**
    *   Ve a [Render Dashboard](https://dashboard.render.com).
    *   Haz clic en **New +** -> **Blueprint**.
    *   Conecta tu repositorio de GitHub.
    *   Render detectará el archivo `render.yaml` y configurará n8n y PostgreSQL automáticamente.

3.  **Configura tu n8n en la nube:**
    *   Una vez desplegado, accede a tu URL de Render.
    *   Importa el workflow: `workflows/01_Master_Orchestrator_Render.json`.
    *   En el nodo de Postgres, asegúrate de configurar las credenciales usando las variables de entorno que Render inyecta automáticamente (ya están configuradas en el `render.yaml`).

4.  **Crea la tabla en la base de datos:**
    *   En n8n, puedes usar un nodo de Postgres para ejecutar este SQL una sola vez:
    ```sql
    CREATE TABLE IF NOT EXISTS job_offers (
        id SERIAL PRIMARY KEY,
        title TEXT,
        url TEXT UNIQUE,
        score INTEGER,
        analysis TEXT,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    ```

## 📂 Estructura

*   `workflows/`: Los archivos .json que contienen la lógica de automatización.
*   `docs/`: Documentación técnica y guía de scraping.
*   `database/`: Scripts SQL.
