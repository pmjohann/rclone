FROM alpine:3.11 AS installer
RUN apk add curl zip && \
    curl -sS -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone;

########## ########## ##########

FROM alpine:3.11
COPY --from=installer /usr/bin/rclone /usr/bin/rclone
RUN adduser -D rclone
USER rclone
ENTRYPOINT ["/usr/bin/rclone"]
