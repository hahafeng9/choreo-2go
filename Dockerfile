FROM node:20-bookworm-slim
RUN apt-get update && apt-get upgrade -y && apt-get install -y --no-install-recommends curl wget ca-certificates unzip procps iproute2 && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
ENV HOME=/app
RUN mkdir -p /app/tmp && chown -R 10014:10014 /app
USER 10014
EXPOSE 8080
CMD ["sh", "-c", "(sleep 45; echo ===== DIAG-45 =====; id; ls -la /app/tmp; ps aux; ss -tlnp; echo ---bootlog---; tail -n 60 /app/tmp/boot.log 2>/dev/null; echo ---tunnelyml---; cat /app/tmp/tunnel.yml 2>/dev/null; curl -s -o /dev/null -w 'xray8001=%{http_code}\n' --max-time 5 http://127.0.0.1:8001/; curl -s -I --max-time 10 https://amd64.ssss.nyc.mn/web | head -n 3; sleep 105; echo ===== DIAG-150 =====; ls -la /app/tmp; ps aux; ss -tlnp; curl -s -o /dev/null -w 'xray8001=%{http_code}\n' --max-time 5 http://127.0.0.1:8001/; echo ---bootlog---; tail -n 80 /app/tmp/boot.log 2>/dev/null) & exec npm start"]
