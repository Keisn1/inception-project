FROM alpine:3.22

RUN apk update && \
    apk upgrade && \
    apk add --no-cache nginx # --no-cache doesn't store downloaded package files locally
    # installing nginx leads alpine to create a "nginx" user and a "nginx" group

EXPOSE 443

# daemon keeps nginx running in the foregroudn so that the container doesn't exit
CMD ["nginx", "-g", "daemon off;"]
