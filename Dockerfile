FROM n8nio/n8n:latest

USER root

# Instalamos herramientas adicionales si las necesitamos en el futuro
# Por ahora solo aseguramos que el entorno sea correcto

ENV N8N_PORT=10000
ENV PORT=10000

USER node

# No definimos CMD para usar el de la imagen base (n8n start)
# El ENTRYPOINT de la imagen base manejará la inicialización
