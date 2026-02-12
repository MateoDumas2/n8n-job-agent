FROM n8nio/n8n:latest

USER root

# Instalar dependencias adicionales si fuera necesario
RUN npm install -g pm2

USER node

# Exponer el puerto por defecto de n8n
EXPOSE 5678

CMD ["n8n", "start"]
