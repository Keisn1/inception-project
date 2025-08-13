FROM alpine:3.22
LABEL maintainer="Kay Freyer <kay.freyer@icloud.com>"

RUN apk update && \
    apk upgrade && \
    apk add --no-cache nginx # --no-cache don't store downloaded package files locally
    # installing nginx leads alpine to create a "nginx" user and a "nginx" group

COPY /conf/nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /var/www/html      # create standard web root directory

RUN chown nginx:nginx /var/www/html # set owner of /var/www/html to nginx
    # nginx is going to be run by nginx user
    # without changing the owner, nginx may not have permissions to read
    # may not have permission to upload neither

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
    # daemon keeps nginx running in the foregroudn so that the container doesn't exit
