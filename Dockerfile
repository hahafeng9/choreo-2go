FROM node:20-bookworm-slim
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends curl wget ca-certificates unzip && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
ENV HOME=/app
RUN mkdir -p /app/tmp && chown -R 10014:10014 /app
USER 10014
EXPOSE 8080
CMD ["npm", "start"]
