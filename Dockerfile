FROM alpine:latest

RUN apk update && apk add curl bash

ADD entrypoint.sh /root/entrypoint.sh

RUN chmod +x /root/entrypoint.sh

WORKDIR /root

ENTRYPOINT ["/root/entrypoint.sh"]
