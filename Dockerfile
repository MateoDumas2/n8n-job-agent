FROM n8nio/n8n:latest

USER root

# No instalamos pm2 para simplificar y asegurar que n8n sea el proceso principal
# n8n ya está en el PATH de la imagen oficial

USER node

# Render usa la variable PORT (por defecto 10000)
# n8n escucha en el puerto 5678 por defecto, pero lo mapearemos
EXPOSE 5678

# Usamos el comando simple. En la imagen oficial 'n8n' está en el PATH.
CMD ["n8n", "start"]
