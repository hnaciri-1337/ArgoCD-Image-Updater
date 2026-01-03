FROM node:20-alpine

WORKDIR /app

COPY server.js .

EXPOSE 1337

CMD ["node", "server.js"]
