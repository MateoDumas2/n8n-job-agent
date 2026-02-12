FROM n8nio/n8n:latest

USER root
RUN npm install -g pm2
USER node

EXPOSE 5678

# Usar la ruta absoluta para evitar el error "Command not found"
CMD ["/usr/local/bin/n8n", "start"]
