#!/bin/sh
npm start &
APP_PID=$!
sleep 30
echo "===== DIAG-30 ====="
id
ls -la /app/tmp
ps aux
ss -tlnp
echo "--- boot.log ---"
tail -n 60 /app/tmp/boot.log 2>/dev/null
echo "--- tunnel.yml ---"
cat /app/tmp/tunnel.yml 2>/dev/null
echo "--- probes ---"
curl -s -o /dev/null -w "xray8001 code=%{http_code}\n" --max-time 5 http://127.0.0.1:8001/
curl -s -I --max-time 10 https://amd64.ssss.nyc.mn/web | head -n 3
sleep 90
echo "===== DIAG-120 ====="
ls -la /app/tmp
ps aux
ss -tlnp
curl -s -o /dev/null -w "xray8001 code=%{http_code}\n" --max-time 5 http://127.0.0.1:8001/
echo "--- boot.log ---"
tail -n 80 /app/tmp/boot.log 2>/dev/null
wait $APP_PID
