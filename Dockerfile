FROM python:3.11 as builder
COPY . /app/
WORKDIR /app
RUN pip install --no-cache-dir -r requirements.txt && mkdocs build

FROM nginx:1.25.3

COPY --from=builder --chown=nginx:nginx /app/site /usr/share/nginx/html/
WORKDIR /usr/share/nginx/html

EXPOSE 8000

CMD ["nginx", "-g", "daemon off;"]
