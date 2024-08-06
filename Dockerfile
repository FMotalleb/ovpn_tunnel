FROM dperson/openvpn-client:latest

COPY warp /bin/

RUN /bin/sh -c "apk --no-cache --no-progress upgrade && apk --no-cache --no-progress add supervisor && chmod +x /bin/warp"
COPY /supervisor/ /etc/supervisor.d/

ENV LISTEN_ADDRESS=0.0.0.0
ENV LISTEN_PORT=443
ENV LISTEN_PROTOCOL=tcp
ENV REMOTE_ADDRESS=1.1.1.1
ENV REMOTE_PORT=443
ENV REMOTE_PROTOCOL=tcp
ENV MAX_THREADS=50
ENV TIMEOUT=0

ENTRYPOINT [ "/bin/sh" , "-c"]
CMD ["supervisord -n -c /etc/supervisord.conf "]