FROM archlinux:latest
RUN echo y | pacman -Sy
RUN echo y | pacman -S v2ray glibc wget git
#同步系统时间
RUN ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

RUN wget -P /usr/bin https://github.com/caddyserver/caddy/releases/download/v1.0.4/caddy_v1.0.4_linux_amd64.tar.gz
RUN tar -zxvf /usr/bin/caddy_v1.0.4_linux_amd64.tar.gz -C /usr/bin
RUN chmod +x /usr/bin/caddy
RUN mkdir /wwwroot
RUN git clone https://github.com/xiongbao/we.dog
RUN mv we.dog/* /wwwroot
RUN rm -rf /we.dog

ADD Caddyfile /etc/Caddyfile

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 80
ENTRYPOINT ["/entrypoint.sh"]
