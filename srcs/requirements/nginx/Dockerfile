FROM alpine:3.21

RUN apk update && \
    apk upgrade && \
    apk add --no-cache nginx openssl # --no-cache doesn't store downloaded package files locally
    # installing nginx leads alpine to create a "nginx" user and a "nginx" group

EXPOSE 443

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/kfreyer.42.fr.key \
    -out /etc/nginx/ssl/kfreyer.42.fr.crt \
    -subj "/C=DE/ST=Niedersachsen/L=Wolfsburg/O=42School/CN=kfreyer.42.fr"

# daemon keeps nginx running in the foregroudn so that the container doesn't exit
CMD ["nginx", "-g", "daemon off;"]
