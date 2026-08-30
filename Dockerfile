FROM node:22-bookworm-slim

WORKDIR /app

RUN apt-get update \
    && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/*

COPY BTC-Radar-LIA-FINAL.zip /tmp/app.zip

RUN unzip -q /tmp/app.zip -d /app \
    && rm /tmp/app.zip \
    && sed -i "s#app.get('\\*',(req,res)=>#app.get('/{*splat}',(req,res)=>#" /app/server/index.mjs \
    && npm install --omit=dev

ENV NODE_ENV=production

EXPOSE 3000

CMD ["npm", "start"]
