FROM alpine:3.12 AS installer
RUN apk add curl zip && \
    curl -sS -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
    unzip rclone-current-linux-amd64.zip && \
    cd rclone-*-linux-amd64 && \
    cp rclone /usr/bin/ && \
    chown root:root /usr/bin/rclone && \
    chmod 755 /usr/bin/rclone;

########## ########## ##########

FROM alpine:3.12
COPY --from=installer /usr/bin/rclone /usr/bin/rclone
RUN adduser -D rclone && \
    mkdir -p /home/rclone/.config/rclone && \
    touch /rclone.conf && \
    ln -s /rclone.conf /home/rclone/.config/rclone/rclone.conf && \
    chown -R rclone:rclone /home/rclone
USER rclone
ENTRYPOINT ["/usr/bin/rclone"]
