# Configuración de Google Sheets para el Agente

Para que el agente guarde las ofertas, necesitamos una Hoja de Cálculo preparada.

## 1. Crear la Hoja
1. Ve a [Google Sheets](https://sheets.new) y crea una nueva hoja.
2. Ponle de nombre: `Agente Busqueda Laboral`.
3. En la primera fila (encabezados), escribe exactamente estos nombres en orden (A1 a H1):
   * `hash_id`
   * `title`
   * `company`
   * `location`
   * `url`
   * `source_portal`
   * `discovered_at`
   * `status`

## 2. Conectar en n8n
1. Abre el workflow **01_Master_Orchestrator_GSheets**.
2. Haz doble clic en el nodo **Guardar en Google Sheets**.
3. En **Credentials**, selecciona "Create New" -> **Google Sheets OAuth2 API**.
   * Sigue los pasos de n8n para loguearte con tu cuenta de Google.
4. En **Sheet ID**, busca el ID en la URL de tu hoja de cálculo:
   * URL: `docs.google.com/spreadsheets/d/1A2b3C4d5E6f.../edit`
   * El ID es la parte larga entre `/d/` y `/edit`.
   * Copia y pega ese ID en el campo `Sheet ID` (o usa el selector de lista si te carga).

¡Listo! Ahora cada vez que corras el agente, las ofertas aparecerán ahí.
