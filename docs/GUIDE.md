# Guía del Agente de Búsqueda Laboral

## Estrategias Anti-Bloqueo y Buenas Prácticas

El scraping de portales de empleo es delicado. Los sitios como LinkedIn tienen medidas de seguridad muy altas.

### 1. Cabeceras HTTP (Headers)
Siempre configura tus nodos **HTTP Request** con headers realistas.
- `User-Agent`: Usa uno real de Chrome/Firefox (ej. `Mozilla/5.0 ...`).
- `Accept-Language`: `es-ES,es;q=0.9`.
- `Referer`: Si paginas, pon la URL anterior como referer.

### 2. Rate Limiting (Velocidad)
No bombardees el sitio.
- Usa el nodo **Wait** en n8n entre requests (ej. espera aleatoria entre 5 y 15 segundos).
- Si usas `SplitInBatches`, procesa de a 1 ítem y pon un delay.

### 3. Rotación de IPs (Avanzado)
Si ejecutas esto desde tu casa (IP residencial), es más seguro. Si lo ejecutas desde la nube (AWS/DigitalOcean), tu IP será bloqueada rápido.
- **Solución:** Usa servicios de Proxy en tus nodos HTTP Request.
- **Alternativa Pro:** Usa APIs de Scraping como *ScrapingBee* o *ZenRows*. En n8n, simplemente cambias el nodo "HTTP Request" para apuntar a la API de ellos en lugar del sitio directo.

### 4. Manejo de Errores (Error Trigger)
Configura en n8n el "Error Workflow".
- Si un nodo falla (403 Forbidden), no detengas todo.
- Marca ese portal como "Error" en la base de datos y sigue con el siguiente.

## Evolución del Sistema (Ideas Futuras)

1.  **Integración con OpenAI (GPT-4o-mini)**
    *   Usa un nodo de IA para leer la `description` cruda.
    *   Prompt: "Extrae el stack tecnológico y clasifica el seniority de este texto: [description]".
    *   Guarda el JSON resultante en `normalized_role` y `tech_stack`.

2.  **Alertas en Telegram**
    *   Crea un bot de Telegram.
    *   Agrega un nodo al final del Master Workflow.
    *   Lógica: `IF match_score > 80 THEN Send Telegram Message`.

3.  **Dashboard**
    *   Conecta Grafana o Metabase a tu base de datos PostgreSQL.
    *   Visualiza: "Ofertas nuevas por día", "Tecnologías más demandadas".
